//
//  SupermarketService.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 26/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import LLVS
import LLVSCloudKit
import CloudKit
import Combine

public final class SupermarketService: ObservableObject {
    
    static let identifier = "iCloud.com.douglastaquary.supermarketui"
    static let mainZone = "MainZone"
    static let mainStore = "MainStore"
    
    lazy public var storeCoordinator: StoreCoordinator = {
        LLVS.log.level = .verbose
        let coordinator = try! StoreCoordinator()
        let container = CKContainer(identifier: SupermarketService.identifier)
        let exchange = CloudKitExchange(with: coordinator.store, storeIdentifier: SupermarketService.mainStore, cloudDatabaseDescription: .privateDatabaseWithCustomZone(container, zoneIdentifier: SupermarketService.mainZone))
        coordinator.exchange = exchange
        exchange.subscribeForPushNotifications()
        return coordinator
    }()
    
    private var supermarketSubscriber: AnyCancellable?
    
    public init() {
        supermarketSubscriber = storeCoordinator.currentVersionSubject
            .receive(on: DispatchQueue.main)
            .map( { self.fetchedSupermarkets(at: $0) })
            .assign(to: \.supermarkets, on: self)
    }
    
    @Published var supermarkets: [Supermarket] = []

    private func fetchedSupermarkets(at version: Version.Identifier) -> [Supermarket] {
        return try! Supermarket.all(in: storeCoordinator, at: version).sorted(by: {
            (($0.name, $0.id.uuidString) < ($1.name, $1.id.uuidString))
        })
    }
    
    func addNewCart(_ cart: Supermarket) {
        let change: Value.Change = .insert(try! cart.encodeValue())
        try! storeCoordinator.save([change])
        sync()
    }
    
    func update(_ supermarket: Supermarket) {
        let change: Value.Change = .update(try! supermarket.encodeValue())
        try! storeCoordinator.save([change])
        sync()
    }
    
    func deleteSupermarket(withID id: Supermarket.ID) {
        let change: Value.Change = .remove(Supermarket.storeValueId(for: id))
        try! storeCoordinator.save([change])
        sync()

    }
    
    func fetchSupermarketItem(for id: Supermarket.ID, with uuid: UUID) -> SupermarketItem {
        let superMark = supermarket(withID: id)
        return superMark.items.first(where: { $0.id == uuid }) ?? SupermarketItem()
    }
    
    func supermarket(withID id: Supermarket.ID) -> Supermarket {
        return supermarkets.first(where: { $0.id == id }) ?? Supermarket()
    }
    
    func fetchItems(for id: Supermarket.ID) -> [SupermarketItem] {
        
        let superMark = supermarket(withID: id)
        
        return superMark.items
    }
    
    func addItem(for id: Supermarket.ID, with content: SupermarketItem) {
        var item = supermarket(withID: id)
        item.items.append(content)
        update(item)
        sync()
    }
    
    // MARK: Syncing
    
    func sync(executingUponCompletion completionHandler: ((Swift.Error?) -> Void)? = nil) {
        storeCoordinator.exchange { _ in
            self.storeCoordinator.merge()
        }
    }
}
