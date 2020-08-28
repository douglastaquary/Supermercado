//
//  HomeItem.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

struct HomeItem: Identifiable {
    let id: UUID = UUID()
    var imageBackgroung: String
    var icon: String
    var text: String
}


