//
//  CartCategory.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation

public struct CartCategory: Codable, Identifiable, Hashable {
    public var id : Int = .init()
    public var isSelected: Bool = false
    public var iconName: IconName = .undefined
    public var categotyTitle: String = ""
}
