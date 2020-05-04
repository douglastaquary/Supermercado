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
    @Published var measureName = ""
    @Published var amount: String = ""
    @Published var howMuchText = ""
    @Published var cartID: Cart.ID
    @Published var supermarketItem: SupermarketItem
    // output
    @Published var supermarketMessage = "0 a 60"
    @Published var measuresTitle = ""
    @Published var totalValue = ""
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
    
    private var isAmountValidPublisher: AnyPublisher<Bool, Never> {
      $amount
        .debounce(for: 0.2, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            self.supermarketItem.amount = self.amount
            return input.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    
    private var isHowMuchTextValidPublisher: AnyPublisher<String, Never> {
      $howMuchText
        .debounce(for: 0.2, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { price in
            self.supermarketItem.price = price
            return self.supermarketItem.price
        }
        .eraseToAnyPublisher()
    }
    
    private var isCategoryNameValidPublisher: AnyPublisher<Bool, Never> {
      $categoryName
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            self.supermarketItem.category = self.categoryName
            return input.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    private var pickerMeasureValuePublisher: AnyPublisher<Bool, Never> {
      $measureName
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .throttle(for: 0.3, scheduler: RunLoop.main, latest: true)
        .map { input in
            self.supermarketItem.measure = self.measureName
            return input.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    var readyToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3(isSupermarketNameValidPublisher, isAmountValidPublisher, isCategoryNameValidPublisher)
            .map { name, category, amount in
                return name && category && amount
            }
            .eraseToAnyPublisher()
    }
    
    var total: AnyPublisher<String, Never> {
        return Publishers.CombineLatest($amount, $howMuchText)
            .map { newAmount, price in
                let amountInt = Int(newAmount) ?? 1
                let priceInt = Int(price) ?? 0
                let result = priceInt * amountInt
                if result > 0 { return "R$ \(result)"}
                
                return ""
            }
            .eraseToAnyPublisher()
    }
    
    var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.groupingSeparator = "."
        
        //        formatter.minimumFractionDigits = .
        //        formatter.maximumFractionDigits = NumberFormatter.currency.maximumFractionDigits
        return formatter
    }()
    
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
        
        readyToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
//        total
//            .receive(on: RunLoop.main)
//            .assign(to: \.howMuchText, on: self)
//            .store(in: &cancellableSet)

        
    }

}

