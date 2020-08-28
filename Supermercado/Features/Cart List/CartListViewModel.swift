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
    @Published var idsToRemove: [Int] = []
    // output
    @Published var carts: [Cart] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {}
    
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
    
    
    func deletCarts(to ids: [UUID]) {
        _ = UserCollection.shared
            .deleteCarts(to: self.idsToRemove)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .assign(to: \.carts, on: self)
            .store(in: &cancellableSet)
        
    }
    
}

