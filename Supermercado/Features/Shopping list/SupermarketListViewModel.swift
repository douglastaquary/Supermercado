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

class SupermarketListViewModel: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()

    let service = UserCollection.shared
    
    @Published var idsToRemove: [UUID] = []
    @Published var loadingData: Bool = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    @State var cart: Cart
    @Published var sections: [ListSection] = []
    
    init(cart: Cart) {
        self.cart = cart
        
        service
            .updateSections(to: cart.id)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .assign(to: \.sections, on: self)
            .store(in: &cancellableSet)
    }

    var items: [SupermarketItem] {
        return service.fetchItems(for: cart.id)
    }
    
    var count: Int {
        return items.count
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

}

