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
    var sections: [ListSection] = []

    init(cart: Cart) {
        self.cart = cart
    }

    var items: [SupermarketItem] {
        return supermarketService.fetchItems(for: cart.id)
    }
    
    var count: Int {
        return items.count
    }
    
    var rows: [ListSection] {
       return updateSections()
    }

    public func updateSections() -> [ListSection] {
        let categories = removeRelaceCategoryIfNeeded(to: items.map { $0.category })
        let sections = performSections(to: categories)
        
        return sections
    }
    
    private func removeRelaceCategoryIfNeeded(to categories: [String]) -> [String] {
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
    
    private func performSections(to categories: [String]) -> [ListSection] {
        sections.removeAll()
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
        return supermarketService.carts.first(where:
            { $0.id == id }
        ) ?? Cart(name: "", iconName: .undefined)
    }
    
    func fetchItem(for id: Cart.ID, with uuid: UUID) -> SupermarketItem {
        let cart = supermarketService.cart(withID: id)
        return cart.items.first(where: { $0.id == uuid }) ?? SupermarketItem()
    }

}

