//
//  SupermarketSetupViewModel.swift
//  Supermercado
//
//  Created by Douglas Taquary on 21/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Combine
import SwiftUI
import Foundation

class SupermarketSetupViewModel: ObservableObject {
    // input
    @Published var supermarketName = ""
    @Published var categoryName = ""
    @Published var measureIndex: Int = 0
    @Published var cartID: Cart.ID
    @Published var supermarketItem: SupermarketItem
    // output
    @Published var supermarketMessage = "0 a 60"
    @Published var measuresTitle = ""
    @Published var isValid = false
    @Published var isCategoryValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isSupermarketNameValidPublisher: AnyPublisher<Bool, Never> {
      $supermarketName
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            self.supermarketItem.name = self.supermarketName
            return input.count >= 3
        }
        .eraseToAnyPublisher()
    }
    
    private var isCategoryNameValidPublisher: AnyPublisher<Bool, Never> {
      $categoryName
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            self.supermarketItem.measure = self.categoryName
            return input.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    private var pickerMeasureValuePublisher: AnyPublisher<String, Never> {
      $measureIndex
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .map { index -> String in
            print("\(Mock.Setup.measures[index].tipo)")
            return Mock.Setup.measures[index].tipo
        }
        .eraseToAnyPublisher()
    }
    
    init(cartID: UUID, supermarketItem: SupermarketItem) {
        self.cartID = cartID
        self.supermarketItem = supermarketItem
        
        isSupermarketNameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "0 a 60" : "O nome do item de compra não pode estar vazio"
            }
            .assign(to: \.supermarketMessage, on: self)
            .store(in: &cancellableSet)
        
        isSupermarketNameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
        isCategoryNameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isCategoryValid, on: self)
            .store(in: &cancellableSet)
    }

}

