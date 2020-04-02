//
//  Address.swift
//  Supermercado
//
//  Created by Douglas Taquary on 01/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

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

