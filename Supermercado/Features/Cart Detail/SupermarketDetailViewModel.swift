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

public final class SupermarketDetailViewModel: ObservableObject {
    
    let supermarketService: SupermarketService = SupermarketService()
    var supermarket: Supermarket

    init(supermarket: Supermarket) {
        self.supermarket = supermarket
    }

    var items: [SupermarketItem] {
        return supermarketService.fetchItems(for: supermarket.id)
    }

    // MARK: - CRUD
    
    func addItem(for id: Supermarket.ID, with content: SupermarketItem) {
        var item = supermarketService.supermarket(withID: id)
        item.items.append(content)
        supermarketService.sync()
    }

    func updateItem(for id: Supermarket.ID, with content: SupermarketItem) {
        var item = supermarketService.supermarket(withID: id)
        item.items.removeAll(where: { $0.id == content.id})
        supermarketService.sync()
    }
    
    func deleteItem(for id: Supermarket.ID, with content: SupermarketItem) {
        var supermarket = supermarketService.supermarket(withID: id)
        supermarket.items.removeAll(where: { $0.id == content.id})
        supermarketService.sync()
    }
    
    func supermarket(withID id: Supermarket.ID) -> Supermarket {
        return supermarketService.supermarkets.first(where: { $0.id == id }) ?? Supermarket()
    }
    
    func fetchItem(for id: Supermarket.ID, with uuid: UUID) -> SupermarketItem {
        let superMark = supermarketService.supermarket(withID: id)
        return superMark.items.first(where: { $0.id == uuid }) ?? SupermarketItem()
    }

}

