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
    @Published var categorySelected: Int = 0
    // output
    @Published var isValid = false
    @Published var cartMessage = "Ex: Compras para o escritório"
    
    var gridCategories: [[CartCategory]] = [[]]

    @Published var categories: [CartCategory] = [
        CartCategory(id: 0, iconName: "ic_shopping_cart", categotyTitle: "Compras do mês"),
        CartCategory(id: 1, iconName: "ic_compras_rapidas", categotyTitle: "Compras rápidas"),
        CartCategory(id: 2, iconName: "carnes", categotyTitle: "Carnes"),
        CartCategory(id: 3, iconName: "festas", categotyTitle: "Festa"),
        CartCategory(id: 4, iconName: "legumes", categotyTitle: "Fitness"),
        CartCategory(id: 5, iconName: "ic_pet", categotyTitle: "Pet"),
    ]
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isCartNameValidPublisher: AnyPublisher<Bool, Never> {
      $cartname
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
          return input.count >= 4
        }
        .eraseToAnyPublisher()
    }
    
    private var sortedCategoriesValidPublisher: AnyPublisher<[CartCategory], Never> {
      $categorySelected
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { index -> [CartCategory] in
            for i in 0..<self.categories.count {
                self.categories[i].isSelected = false
            }
            self.categories[index].isSelected = true
            return self.categories
        }
        .eraseToAnyPublisher()
    }

    init() {
        
        _ = categories.publisher
            .collect(3)
            .collect()
            .sink(receiveValue: { self.gridCategories = $0 })
        
        sortedCategoriesValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.categories, on: self)
            .store(in: &cancellableSet)
        
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
    }

}


