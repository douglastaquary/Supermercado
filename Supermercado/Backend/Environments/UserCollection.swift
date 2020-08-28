//
//  UserCollection.swift
//  
//
//  Created by Douglas Taquary on 19/08/20.
//

import Foundation
import Combine
import CloudKit
import os.log

public class UserCollection: ObservableObject {
    public static let shared = UserCollection(iCloudDisabled: false)
    
    // MARK: - Published properties
    @Published public var carts: [Cart] = []
    @Published var sections: [ListSection] = []
    @Published public var isCloudEnabled = true
    @Published public var isSynched = false
    
    // MARK: - Private properties
    private struct SavedData: Codable {
        let carts: [Cart]
    }
    
    private let filePath: URL
    private let sharedFilePath: URL?
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let saveQueue = DispatchQueue(label: "bag.save.queue")
    
    private static let recordType = "UserCollection"
    private static let recordId = CKRecord.ID(recordName: "CurrentUserCollection")
    private static let assetKey = "data"
    private var cloudKitDatabase: CKDatabase? = nil
    private var currentRecord: CKRecord? = nil
    
    private let logHandler = OSLog(subsystem: "com.bag.collection", category: "bag-perf")
    
    public init(iCloudDisabled: Bool, fromSharedURL: Bool = false) {
        do {
            filePath = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appendingPathComponent("collection")
            
            sharedFilePath = FileManager.default.containerURL(
                    forSecurityApplicationGroupIdentifier: "group.bag.com"
            )?.appendingPathComponent("collection")
            
            if fromSharedURL, let url = sharedFilePath {
                _ = self.loadUserCollection(file: url)
            } else {
                _ = self.loadUserCollection(file: filePath)
            }
            
            if !iCloudDisabled {
                checkiCloudStatus()
            } else {
                isCloudEnabled = false
            }
                        
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    private func subscribeToCloudKit() {
        cloudKitDatabase?.fetchAllSubscriptions { (subs, _) in
            if subs == nil || subs?.isEmpty == true {
                self.createSubscription()
            }
        }
    }
    
    // MARK: - CloudKit
    private func checkiCloudStatus() {
        CKContainer.default().accountStatus { (status, error) in
            if error != nil || status != .available {
                DispatchQueue.main.async {
                    self.isCloudEnabled = false
                }
            } else {
                self.cloudKitDatabase = CKContainer.default().privateCloudDatabase
                self.reloadFromCloudKit()
                self.subscribeToCloudKit()
            }
        }
    }
    
    private func createSubscription() {
        let sub = CKQuerySubscription(recordType: Self.recordType,
                                      predicate: NSPredicate(value: true),
                                      options: .firesOnRecordUpdate)
        let notif = CKSubscription.NotificationInfo()
        notif.shouldSendContentAvailable = true
        sub.notificationInfo = notif
        cloudKitDatabase?.save(sub) { (_, _) in }
    }
    
    public func reloadFromCloudKit() {
        cloudKitDatabase?.fetch(withRecordID: Self.recordId) { (record, error) in
            if record == nil {
                DispatchQueue.main.async {
                    self.save()
                }
            } else {
                self.currentRecord = record
                if let asset = record?[Self.assetKey] as? CKAsset,
                    let url = asset.fileURL {
                    DispatchQueue.main.async {
                        self.isSynched = true
                        _ = self.loadUserCollection(file: url)
                        try? FileManager.default.removeItem(at: self.filePath)
                        try? FileManager.default.copyItem(at: url, to: self.filePath)
                    }
                }
            }
        }
    }
    
    private func saveToCloudKit() {
        if let record = currentRecord {
            record[Self.assetKey] = CKAsset(fileURL: filePath)
            let modified = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
            modified.savePolicy = .allKeys
            modified.completionBlock = {
                DispatchQueue.main.async {
                    self.isSynched = true
                }
            }
            cloudKitDatabase?.add(modified)
        } else {
            let record = CKRecord(recordType: Self.recordType,
                                  recordID: Self.recordId)
            let asset = CKAsset(fileURL: filePath)
            record[Self.assetKey] = asset
            
            cloudKitDatabase?.save(record) { (record, error) in
                DispatchQueue.main.async {
                    self.currentRecord = record
                    self.isSynched = true
                }
            }
        }
    }
    
    // MARK: - Import / Export
    private func save() {
        saveQueue.async { [weak self] in
            guard let self = self else { return }
            do {
                let savedData = SavedData(carts: self.carts)
                let data = try self.encoder.encode(savedData)
                try data.write(to: self.filePath, options: .atomicWrite)
                if let url = self.sharedFilePath {
                    try data.write(to: url, options: .atomicWrite)
                }
                
                if self.isCloudEnabled {
                    DispatchQueue.main.async {
                        self.isSynched = false
                        self.saveToCloudKit()
                    }
                }
            } catch let error {
                print("Error while saving collection: \(error.localizedDescription)")
            }
            self.encoder.dataEncodingStrategy = .base64
        }
    }
    
    private func loadUserCollection(file: URL) -> Bool {
        if let data = try? Data(contentsOf: file) {
            decoder.dataDecodingStrategy = .base64
            do {
                let savedData = try decoder.decode(SavedData.self, from: data)
                self.carts = savedData.carts
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    public func deleteUserCollection() -> Bool {
        do {
            try FileManager.default.removeItem(at: filePath)
            self.carts = []
            save()
            return true
        } catch {
            return false
        }
    }
    
    public func generateExportURL() -> URL? {
        do {
            var sharedURL = try FileManager.default.url(for: .documentDirectory,
                                                                    in: .userDomainMask,
                                                                    appropriateFor: nil,
                                                                    create: false)
            sharedURL.appendPathComponent("exported-collection")
            sharedURL.appendPathExtension("app-bag")
            try? FileManager.default.removeItem(at: sharedURL)
            try FileManager.default.copyItem(at: filePath, to: sharedURL)
            return sharedURL
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func sizeOfArchivedState() -> String {
        do {
            let resources = try filePath.resourceValues(forKeys:[.fileSizeKey])
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = .useKB
            formatter.countStyle = .file
            return formatter.string(fromByteCount: Int64(resources.fileSize ?? 0))
        } catch {
            return "0"
        }
    }
    
    public func processImportedFile(url: URL) -> Bool {
        let success = loadUserCollection(file: url)
        if success {
            save()
        }
        return success
    }
    
    func performSections(to cartID: Int) -> [ListSection] {
        let items = fetchItems(for: cartID)
        let categories = removeRelaceCategoryIfNeeded(to: items.map { $0.category })
        let sections = performSections(to: categories, with: cartID)
        
        return sections
        
    }
    
    private func performSections(to categories: [String], with cartID: Int) -> [ListSection] {
        sections.removeAll()
        let items = fetchItems(for: cartID)
        for category in categories {
            var section: ListSection = ListSection()
            section.name = category
            for supermarket in items {
                if supermarket.category.lowercased() == category.lowercased() {
                    section.items.append(supermarket)
                }
            }
            sections.append(section)
        }
        
        return sections
    }
    
    func updateSections(to cartID: Int) -> AnyPublisher<[ListSection], Never> {
        return Future { [weak self] resolve in
            let items = self?.fetchItems(for: cartID)
            let categories = self?.removeRelaceCategoryIfNeeded(to: items?.map { $0.category } ?? [])
            let sections = self?.performSections(to: categories ?? [], with: cartID)
            return resolve(.success(sections ?? []))
            
        }.eraseToAnyPublisher()
    }
    
    func cart(withID id: Int) -> Cart {
        return carts.first(where: { $0.id == id }) ?? Cart(name: "", iconName: .undefined)
    }
    
    func removeRelaceCategoryIfNeeded(to categories: [String]) -> [String] {
        var validCategories: [String] = []
        
        for category in categories {
            if validCategories.isEmpty {
                validCategories.append(category)
            } else {
                let valids = validCategories.filter { $0.contains(category) }
                if valids.isEmpty {
                    validCategories.append(category)
                }
            }
        }
        return validCategories
    }
    
    func createSections(to cartID: Int) -> [ListSection] {
        let items = fetchItems(for: cartID)
        let categories = removeRelaceCategoryIfNeeded(to: items.map { $0.category })
        let sections = performSections(to: categories, with: cartID)
        
        return sections
    }
    
    func fetchItems(for id: Int) -> [SupermarketItem] {
        let cart = self.cart(withID: id)
        return cart.items
    }
    
    func updateCart(_ cart: Cart) {
        let index = carts.firstIndex(where: { $0.id == cart.id})!
        carts[index] = cart
        save()
    }
    
    func addNewCart(cart: Cart, _ completion: @escaping (Result<Cart, CloudKitError>) -> Void) {
        carts.append(cart)
        save()
        
        guard let newCart = carts.first(where: { $0.id == cart.id }) else {
            completion(.failure(.unableToAddPurchase))
            return
        }

        completion(.success(newCart))
    }

//    func deleteCarts(to ids: [Int]) {
//        for id in ids {
//            let index = ids.first(where: { $0 == id })!
//            self.carts.remove(at: index)
//        }
//
//        self.save()
//    }
//
//
    func deleteCarts(to ids: [Int]) -> AnyPublisher<[Cart], Never>  {
        return Future { [weak self] resolve in
            for id in ids {
                let index = ids.first(where: { $0 == id })!
                self?.carts.remove(at: index)
            }
            self?.save()
            return resolve(.success(self?.carts ?? []))
            
        }.eraseToAnyPublisher()
    }
    
    func addItem(for id: Int, with content: SupermarketItem) {
        var cart = self.cart(withID: id)
        cart.items.append(content)
        save()
    }
    
    func listItemCount(to cartId: Int) -> Int {
        return self.fetchItems(for: cartId).count
    }
    
    func performDeleteItems(for id: Cart.ID, with ids: [Int]) -> AnyPublisher<[ListSection]?, Never> {
        return Future { [weak self] resolve in
            
            var sections: [ListSection] = []
            var cart = self?.cart(withID: id) ?? Cart(name: "", iconName: IconName.undefined)
            
            for itemID in ids {
                cart.items.removeAll(where: { $0.id == itemID })
                self?.updateCart(cart)
            }
            
            sections = self?.createSections(to: cart.id) ?? []
            return resolve(.success(sections))
            
        }.eraseToAnyPublisher()
    }
    
    

}
