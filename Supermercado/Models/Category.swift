//
//  Category.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct Category: Codable, Identifiable, Hashable {
    public let id = UUID()
    public var tipo: String = ""
}

public enum IconName: String, Codable {
    case beef = "carnes"
    case party = "festas"
    case fastShopping = "ic_compras_rapidas"
    case pet = "ic_pet"
    case shopping = "ic_shopping_cart"
    case vegetables = "legumes"
    case undefined = ""
}

