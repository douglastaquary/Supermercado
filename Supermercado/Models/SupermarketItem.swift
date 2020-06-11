//
//  SupermarketItem.swift
//  Supermercado
//
//  Created by Douglas Taquary on 01/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import UIKit

public struct SupermarketItem: Codable, Equatable, Identifiable {
    public var id: UUID = .init()
    public var name: String = ""
    public var price: String = ""
    public var amount: String = ""
    public var discount: String = ""
    public var avatarJPEGData: Data?
    public var measure: String = ""
    public var category: String = ""
    public var isDone: Bool? = false
    public var isReadyToRemove: Bool? = false

   
    init(name: String = "", price: String = "", amount: String = "", discount: String = "", isDone: Bool = false) {
        self.name = name
        self.price = price
        self.amount = amount
        self.discount = discount
        self.isDone = isDone
    }
    
    public var unitPrice: String {
        let decimalResult = Decimal(fromString: price)
        let newValue = (decimalResult / 100).toBrazilianRealString(withDollarSymbol: true)
        
        return "\(newValue)"
    }
}

