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

//public struct Category: Codable {
//    public let id = UUID()
//}

public struct Category: Codable, Identifiable, Hashable {
    public let id = UUID()
    public var tipo: String = ""
}

struct Supermarket: Model {
    static let storeIdentifierTypeTag = "Supermarket"
    var id: UUID = .init()
    var items: [SupermarketItem] = []
    var name: String = ""
    var address: Address = .init()
    var avatarJPEGData: Data?
}



