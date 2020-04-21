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
    @Published var measureIndex: Int = 0
    // output
    @Published var supermarketMessage = "0 a 60"
    @Published var measuresTitle = ""
    @Published var isValid = false
    @Published var measures: [Medida] = [
    Medida(tipo: "Kilo"),
    Medida(tipo: "Metro"),
    Medida(tipo: "Litro"),
    Medida(tipo: "Milímetro"),
    Medida(tipo: "Centímetro")]
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isSupermarketNameValidPublisher: AnyPublisher<Bool, Never> {
      $supermarketName
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
          return input.count >= 3
        }
        .eraseToAnyPublisher()
    }
    
    private var pickerMeasureValuePublisher: AnyPublisher<String, Never> {
      $measureIndex
        .debounce(for: 0.3, scheduler: RunLoop.main)
        .map { index -> String in
            print("\(self.measures[index].tipo)")
            return self.measures[index].tipo
        }
        .eraseToAnyPublisher()
    }
    
    init() {
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
        
//        pickerMeasureValuePublisher
//            .receive(on: RunLoop.main)
//            .assign(to: \.measuresTitle, on: self)
//            .store(in: &cancellableSet)
        
//        pickerMeasureValuePublisher
//            .receive(on: RunLoop.main)
//            .assign(to: \.measuresTitle, on: self)
//            .store(in: &cancellableSet)
    }
    
    var medidas = [
            Medida(tipo: "Kilo"),
            Medida(tipo: "Metro"),
            Medida(tipo: "Litro"),
            Medida(tipo: "Milímetro"),
            Medida(tipo: "Centímetro")
    ]
    
    var categories: [Category] = [
            Category(tipo: "Cama, mesa e banho"),
            Category(tipo: "Limpeza"),
            Category(tipo: "Bebidas"),
            Category(tipo: "Grãos"),
            Category(tipo: "Legumes e verduras"),
            Category(tipo: "Carnes"),
            Category(tipo: "Outros")
    ]

}

