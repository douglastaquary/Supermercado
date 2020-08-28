//
//  SupermarketItem.swift
//  Supermercado
//
//  Created by Douglas Taquary on 01/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct SupermarketItem: Codable, Equatable, Identifiable, Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(category)
    }
    
    public var id: Int { name.hash }
    public var name: String = ""
    public var price: String = ""
    public var amount: String = ""
    public var discount: String = ""
    public var avatarJPEGData: Data?
    public var measure: String = ""
    public var category: String = ""
    public var isDone: Bool? = false
    public var isReadyToRemove: Bool = false
    
    public init(name: String = "", price: String = "", amount: String = "", discount: String = "", isDone: Bool = false) {
        self.name = name
        self.price = price
        self.amount = amount
        self.discount = discount
        self.isDone = isDone
    }
}

extension SupermarketItem {
    static public func == (lhs: SupermarketItem, rhs: SupermarketItem) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.category == rhs.category
    }
}
