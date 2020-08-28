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
    
    let characterLimit: Int = 60
    
    // input
    @Published var supermarketName = ""
    @Published var categoryName = ""
    @Published var measureName = ""
    @Published var amount: String = ""
    @Published var howMuchText = ""
    var value: Double {
        (Double(self.howMuchText) ?? 0.0) / 100
    }
    @Published var cartID: Int
    @Published var supermarketItem: SupermarketItem
    // output
    @Published var supermarketMessage = "0 a 60"
    @Published var measuresTitle = ""
    @Published var totalValue = ""
    @Published var isValid = false
    @Published var disableTextField = false
    @Published var isCategoryValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []    
    
    private var isSupermarketNameValidPublisher: AnyPublisher<Bool, Never> {
      $supermarketName
        //.debounce(for: 0.1, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            if input.count != 60 {
                self.disableTextField = false
                self.supermarketMessage = "\(input.count) a 60"
            } else {
                self.disableTextField = true
            }
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
        .map { newPrice in
            self.supermarketItem.price = newPrice
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
        .map { input in
            self.supermarketItem.measure = self.measureName
            return input.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    var readyToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3(
            isSupermarketNameValidPublisher,
            isAmountValidPublisher,
            isCategoryNameValidPublisher
        )
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
    

    init(cartID: Int, supermarketItem: SupermarketItem) {
        self.cartID = cartID
        self.supermarketItem = supermarketItem

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


extension Locale {
    static let br = Locale(identifier: "pt_BR")
    static let us = Locale(identifier: "en_US")
    static let uk = Locale(identifier: "en_GB") // ISO Locale
}

extension NumberFormatter {
    convenience init(style: Style, locale: Locale = .current) {
        self.init()
        self.locale = locale
        numberStyle = style
    }
}

extension Formatter {
    static let currency = NumberFormatter(style: .currency)
    static let currencyUS = NumberFormatter(style: .currency, locale: .us)
    static let currencyBR = NumberFormatter(style: .currency, locale: .br)
}

extension Numeric {
    var currency: String { Formatter.currency.string(for: self) ?? "" }
    var currencyUS: String { Formatter.currencyUS.string(for: self) ?? "" }
    var currencyBR: String { Formatter.currencyBR.string(for: self) ?? "" }
}
