//
//  Supermarket.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 19/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import CoreLocation

public struct Supermarket: Codable, Equatable, Identifiable, Hashable {
    
    public static func == (lhs: Supermarket, rhs: Supermarket) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
 
    public var id: Int { (name).hash }
    public var name: String = ""
    var address: Address? = nil
    var avatarJPEGData: Data? = nil
    var location: SupermarketLocation? = nil

    var coodinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: location?.latitude ?? 0.0,
            longitude: location?.longitude ?? 0.0
        )
    }
    
    public init() {}

}

public struct SupermarketLocation: Codable, Equatable, Identifiable, Hashable {
    
    public static func == (lhs: SupermarketLocation, rhs: SupermarketLocation) -> Bool {
        lhs.id == rhs.id &&
        lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
    
    public var id: Int { (latitude + longitude).hashValue }
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
    
    public init() {
    }

}

