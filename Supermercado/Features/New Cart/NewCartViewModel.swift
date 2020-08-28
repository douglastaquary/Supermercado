//
//  NewCartViewModel.swift
//  Supermercado
//
//  Created by Douglas Taquary on 21/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Combine
import SwiftUI
import Foundation

class NewCartViewModel: ObservableObject {
    // input
    @Published var cartname = ""
    @Published var cartIcon = IconName.undefined
    @Published var cart: Cart = Cart(name: "", iconName: .shopping)
    // output
    @Published var isValid = false
    @Published var cartMessage = "Ex: Compras para o escritório"

    @Published var categories: [CartCategory] = [
        CartCategory(iconName: .shopping, categotyTitle: "Compras\ndo mês"),
        CartCategory(iconName: .fastShopping, categotyTitle: "Compras\nrápidas"),
        CartCategory(iconName: .beef, categotyTitle: "Carnes"),
        CartCategory(iconName: .party, categotyTitle: "Festa"),
        CartCategory(iconName: .vegetables, categotyTitle: "Fitness"),
        CartCategory(iconName: .pet, categotyTitle: "Pet"),
    ]
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isCartNameValidPublisher: AnyPublisher<Bool, Never> {
      $cartname
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            self.cart.name = self.cartname
            return input.count >= 4
        }
        .eraseToAnyPublisher()
    }
    
    private var isCartIconValidPublisher: AnyPublisher<[CartCategory], Never> {
      $cartIcon
        .debounce(for: 0.1, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { iconName in
            self.cart.iconName = self.cartIcon
            for i in 0..<self.categories.count {
                if self.categories[i].iconName == iconName {
                    self.categories[i].isSelected = true
                } else {
                    self.categories[i].isSelected = false
                }
            }

            return self.categories
        }
        .eraseToAnyPublisher()
    }
    
    public func categorySelected(on category: CartCategory) {
        self.cartIcon = category.iconName
    }
    
    init() {
        
        isCartNameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "Ex: Compras para o escritório" : "O nome deve ter pelo menos 4 caracteres"
            }
            .assign(to: \.cartMessage, on: self)
            .store(in: &cancellableSet)
        
        isCartNameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
        isCartIconValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.categories, on: self)
            .store(in: &cancellableSet)
    }

}


