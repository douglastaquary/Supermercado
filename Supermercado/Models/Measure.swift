//
//  Measure.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct Measure: Codable, Identifiable, Hashable {
    public let id = UUID()
    public let tipo: String
}

