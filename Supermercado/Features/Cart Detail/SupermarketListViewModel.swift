//
//  SupermarketItemViewModel.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 25/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import LLVS
import LLVSCloudKit
import CloudKit

class SupermarketListViewModel: ObservableObject {
    
    let supermarketService: SupermarketService = SupermarketService()
    var cart: Cart

    init(cart: Cart) {
        self.cart = cart
    }

    var items: [SupermarketItem] {
        return supermarketService.fetchItems(for: cart.id)
    }
    
    var count: Int {
        return items.count
    }

    // MARK: - CRUD
    
    func addItem(for id: Cart.ID, with content: SupermarketItem) {
        var item = supermarketService.cart(withID: id)
        item.items.append(content)
        supermarketService.sync()
    }

    func updateItem(for id: Cart.ID, with content: SupermarketItem) {
        var item = supermarketService.cart(withID: id)
        item.items.removeAll(where: { $0.id == content.id})
        supermarketService.sync()
    }
    
    func deleteItem(for id: Cart.ID, with content: SupermarketItem) {
        var supermarket = supermarketService.cart(withID: id)
        supermarket.items.removeAll(where: { $0.id == content.id})
        supermarketService.sync()
    }
    
    func supermarket(withID id: Cart.ID) -> Cart {
        return supermarketService.carts.first(where: { $0.id == id }) ?? Cart()
    }
    
    func fetchItem(for id: Cart.ID, with uuid: UUID) -> SupermarketItem {
        let cart = supermarketService.cart(withID: id)
        return cart.items.first(where: { $0.id == uuid }) ?? SupermarketItem()
    }

}

