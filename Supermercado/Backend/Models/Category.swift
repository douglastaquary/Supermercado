//
//  Category.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct Category: Codable, Identifiable, Equatable {
    public var id: Int { tipo.hash }
    public var tipo: String
    
    public init(tipo: String) {
        self.tipo = tipo
    }
    
    public static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}

public enum IconName: String, Codable, CaseIterable {
    case beef = "carnes"
    case party = "festas"
    case fastShopping = "ic_compras_rapidas"
    case pet = "ic_pet"
    case shopping = "ic_shopping_cart"
    case vegetables = "legumes"
    case undefined = ""
}

