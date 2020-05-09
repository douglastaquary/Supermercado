//
//  CartListViewModel.swift
//  Supermercado
//
//  Created by Douglas Taquary on 05/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Combine
import Foundation

class CartListViewModel: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()

    // input
    @Published var isReadyToRemove = false
    // output
    var carts: [Cart] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isCartRemoveModeValidPublisher: AnyPublisher<[Cart], Never> {
      $isReadyToRemove
        .debounce(for: 0.1, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { isReady in
            if isReady {
                for i in 0..<self.carts.count {
                    self.carts[i].isReadyToRemove = true
                }
                return self.carts
            }
            
            for i in 0..<self.carts.count {
                self.carts[i].isReadyToRemove = false
            }
            return self.carts
        }
        .eraseToAnyPublisher()
    }
    
    
    func performEditMode(_ isReady: Bool) {
        if isReady {
            for i in 0..<self.carts.count {
                self.carts[i].isReadyToRemove = true
            }
        } else {
            for i in 0..<self.carts.count {
                self.carts[i].isReadyToRemove = false
            }
        }
    

    }
    
    init() {

//        isCartRemoveModeValidPublisher
//            .receive(on: RunLoop.main)
//            .assign(to: \.carts, on: self)
//            .store(in: &cancellableSet)
    }

}

