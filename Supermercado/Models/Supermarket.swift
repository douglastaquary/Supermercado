//
//  Supermarket.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 19/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import CoreLocation

struct Supermarket: Codable {
    //static let storeIdentifierTypeTag = "Supermarket"
    var id: UUID = .init()
    var name: String = ""
    var address: Address = .init()
    var avatarJPEGData: Data?
    var location: SupermarketLocation?
    
    var coodinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: location?.latitude ?? 0.0,
            longitude: location?.longitude ?? 0.0
        )
    }
}

struct SupermarketLocation: Codable {
    let latitude: Double
    let longitude: Double
}

