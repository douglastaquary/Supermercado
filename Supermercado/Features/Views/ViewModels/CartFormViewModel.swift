//
//  AddCardViewModel.swift
//  Supermercado
//
//  Created by Douglas Taquary on 20/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Combine
import Foundation

class CartFormViewModel: ObservableObject {
    // input
    @Published var cartname = ""
    // output
    @Published var cartMessage = ""
    @Published var isValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isCartNameValidPublisher: AnyPublisher<Bool, Never> {
      $cartname
        .debounce(for: 0.8, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
          return input.count >= 4
        }
        .eraseToAnyPublisher()
    }
    
    init() {
        isCartNameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "Ex: Compras para o escritório" : "O nome do carrinho deve ter pelo menos 4 caracteres"
            }
            .assign(to: \.cartMessage, on: self)
            .store(in: &cancellableSet)
        
        
        isCartNameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }

}
