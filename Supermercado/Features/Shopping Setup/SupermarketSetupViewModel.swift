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

public enum SetupPresentationMode {
    case editing
    case adding
}

class SupermarketSetupViewModel: ObservableObject {
        
    let characterLimit: Int = 60
    let service = SupermarketService.shared
    
    // input
    @Published var supermarketName = ""
    @Published var categoryName = ""
    @Published var measureName = ""
    @Published var amount: String = ""
    @Published var howMuchText = ""
    var value: Double {
        (Double(self.howMuchText) ?? 0.0) / 100
    }
    @Published var cartID: Cart.ID
    @Published var setupPresentationMode: SetupPresentationMode
    
    public var idsToEdit: [UUID] = []
    @Published var supermarketItem: SupermarketItem?
    //@Published var setupPresentationMode: SetupPresentationMode = .adding
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
        .debounce(for: 0.1, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            if input.count != 60 {
                self.disableTextField = false
                self.supermarketMessage = " \(input.count) " + " a 60 "
            } else {
                self.disableTextField = true
            }
            self.supermarketItem?.name = self.supermarketName
            return input.count >= 3
        }
        .eraseToAnyPublisher()
    }

    private var isAmountValidPublisher: AnyPublisher<Bool, Never> {
      $amount
        .debounce(for: 0.2, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            self.supermarketItem?.amount = self.amount
            return input.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    
    private var isHowMuchTextValidPublisher: AnyPublisher<String, Never> {
      $howMuchText
        .debounce(for: 0.2, scheduler: RunLoop.main)
        .map { newPrice in
            self.supermarketItem?.price = newPrice
            print("\nPreço: \(newPrice)\n")
            return self.supermarketItem?.price ?? ""
        }
        .eraseToAnyPublisher()
    }
    
    private var isCategoryNameValidPublisher: AnyPublisher<Bool, Never> {
      $categoryName
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            self.supermarketItem?.category = self.categoryName
            return input.count > 0
        }
        .eraseToAnyPublisher()
    }
    
    private var pickerMeasureValuePublisher: AnyPublisher<Bool, Never> {
      $measureName
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .map { input in
            self.supermarketItem?.measure = self.measureName
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
    
    func isEditActionValid(ids: [UUID]) -> Bool {
        if !ids.isEmpty {
            return true
        }
        
        return false
    }
    
    func performEditModeIfNeeded(to ids: [UUID]) {
        if isEditActionValid(ids: ids) && setupPresentationMode == .editing && (ids.count == 1 || idsToEdit.count == 1) {
            self.supermarketItem = service.fetchSupermarketItem(for: cartID, with: ids.first ?? UUID())
            supermarketName = self.supermarketItem?.name ?? ""
            categoryName = self.supermarketItem?.category ?? ""
            measureName = self.supermarketItem?.measure ?? ""
            amount = self.supermarketItem?.amount ?? ""
            howMuchText  = self.supermarketItem?.price ?? ""
        } else {
            self.supermarketItem = SupermarketItem()
        }
    }

    init(cartID: UUID, setupPresentationMode: SetupPresentationMode, ids: [UUID] = []) {
        self.cartID = cartID
        self.setupPresentationMode = setupPresentationMode
        self.idsToEdit = ids
        
        performEditModeIfNeeded(to: ids)
       
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

