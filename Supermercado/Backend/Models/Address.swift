//
//  Address.swift
//  Supermercado
//
//  Created by Douglas Taquary on 01/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct Address: Codable, Equatable, Identifiable, Hashable {
    
    static public func == (lhs: Address, rhs: Address) -> Bool {
        lhs.id == rhs.id &&
        lhs.streetAddress == rhs.streetAddress
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(streetAddress)
        hasher.combine(postCode)
    }
    public var id: String { streetAddress }
    var streetAddress: String = ""
    var postCode: String = ""
    var city: String = ""
    var country: String = ""
    

    public init(streetAddress: String = "", postCode: String = "", city: String = "", country: String = "") {
        self.streetAddress = streetAddress
        self.postCode = postCode
        self.city = city
        self.country = country
    }
    
}

