//
//  File.swift
//  Supermercado
//
//  Created by Douglas Taquary on 01/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

struct ListSection: Equatable, Identifiable {
    let id: UUID = .init()
    var name: String = ""
    var items: [SupermarketItem] = []
    
}
