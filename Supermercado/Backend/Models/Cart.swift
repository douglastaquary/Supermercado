//
//  Cart.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct Cart: Codable, Equatable, Identifiable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
        
    public var id: Int {
        (name + iconName.rawValue).hashValue
    }
    var items: [SupermarketItem] = []
    var name: String
    var iconName: IconName
    var categoryTitle: String = ""
    var address: Address?
    var avatarJPEGData: Data?
    var lastShopping: Supermarket?
    var isReadyToRemove: Bool? = false
//    public var creationDate: Date {
//        record?.creationDate ?? Date()
//    }
//        
    enum RecordKeys: String {
        case id, items, name, iconName, categoryTitle, address, avatarJPEGData, lastShopping
    }
    
//    public init(withRecord record: CKRecord) {
//        items = record[RecordKeys.items.rawValue] as? [SupermarketItem] ?? []
//        name = record[RecordKeys.name.rawValue] as? String ?? ""
//        iconName =  IconName(rawValue: record[RecordKeys.iconName.rawValue] as? String ?? "") ?? .undefined
//        categoryTitle = record[RecordKeys.categoryTitle.rawValue] as? String ?? ""
//        address = record[RecordKeys.address.rawValue] as? Address
//        avatarJPEGData = record[RecordKeys.avatarJPEGData.rawValue] as? Data ?? nil
//        lastShopping = record[RecordKeys.lastShopping.rawValue] as? Supermarket
//        self.record = record
//    }
//    
//    public func toRecord(owner: CKRecord?) -> CKRecord {
//        let record = self.record ?? CKRecord(recordType: Self.RecordType)
//        record[RecordKeys.items.rawValue] = items
//        record[RecordKeys.name.rawValue] = name
//        record[RecordKeys.iconName.rawValue] = iconName.rawValue
//        record[RecordKeys.categoryTitle.rawValue] = categoryTitle
//        
//        if let _address = address {
//            record[RecordKeys.address.rawValue] = _address
//        }
//        
//        if let imgJpegData = avatarJPEGData {
//            record[RecordKeys.address.rawValue] = imgJpegData
//        }
//        
//        if let lastShopping = lastShopping {
//            record[RecordKeys.lastShopping.rawValue] = lastShopping
//        }
//
//        return record
//    }
}

extension Cart {
    public static func == (lhs: Cart, rhs: Cart) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.categoryTitle == rhs.categoryTitle
    }
}

