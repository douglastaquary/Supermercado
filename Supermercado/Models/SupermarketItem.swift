//
//  SupermarketItem.swift
//  Supermercado
//
//  Created by Douglas Taquary on 01/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct SupermarketItem: Codable, Equatable, Identifiable {
    public var id: UUID = .init()
    public var name: String = ""
    public var price: String = ""
    public var amount: Double = 0.0
    public var discount: String = ""
    public var avatarJPEGData: Data?
    public var medida: Medida?
    public var category: Category?

    
    public var fullNameOrPlaceholder: String {
        name.isEmpty ? "Novo item" : name
    }
        
//    init(name: String = "", price: String = "", amount: Double = 0.0, discount: String = "") {
//        self.name = name
//        self.price = price
//        self.amount = amount
//        self.discount = discount
//    }
}

