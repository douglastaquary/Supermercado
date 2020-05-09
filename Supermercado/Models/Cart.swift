//
//  Cart.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

struct Cart: Model {
    
    static let storeIdentifierTypeTag = "Cart"
    var id: UUID = .init()
    var items: [SupermarketItem] = []
    var name: String
    var iconName: IconName
    var categoryTitle: String = ""
    var address: Address = .init()
    var avatarJPEGData: Data?
    var lastShopping: Supermarket?
    var isReadyToRemove: Bool? = false
    
    static func == (lhs: Cart, rhs: Cart) -> Bool {
        return lhs.id == lhs.id
    }
    
}


