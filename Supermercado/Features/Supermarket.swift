//
//  Supermarket.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 19/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import LLVS
import SwiftUI

public struct Medida: Codable, Identifiable, Hashable {
    public let id = UUID()
    public let tipo: String
}

let medidas = [Medida(tipo: "Kilograma"), Medida(tipo: "Ml"), Medida(tipo: "Litros")]


struct Supermarket: Model {
    static let storeIdentifierTypeTag = "Supermarket"
    var id: UUID = .init()
    var items: [SupermarketItem] = []
    var name: String = ""
    var address: Address = .init()
    var avatarJPEGData: Data?
}


/// Person is embedded in Contact, and so not a Model type. It is just Codable.
public struct SupermarketItem: Codable, Equatable, Identifiable {
    public var id: UUID = .init()
    public var name: String = ""
    public var price: String = ""
    public var amount: Double = 0.0
    public var discount: String = ""
    public var avatarJPEGData: Data?
    public var medida: Medida?
    
    public var fullNameOrPlaceholder: String {
        name.isEmpty ? "Novo item" : name
    }
        
    init(name: String = "", price: String = "", amount: Double = 0.0, discount: String = "") {
        self.name = name
        self.price = price
        self.amount = amount
        self.discount = discount
    }
}

/// Address is also embedded, so only Codable.
struct Address: Codable, Equatable {
    var streetAddress: String = ""
    var postCode: String = ""
    var city: String = ""
    var country: String = ""
    
    init(streetAddress: String = "", postCode: String = "", city: String = "", country: String = "") {
        self.streetAddress = streetAddress
        self.postCode = postCode
        self.city = city
        self.country = country
    }
}
