//
//  Decimal+Extensions.swift
//  Supermercado
//
//  Created by Douglas Taquary on 16/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation


extension Decimal {
    
    init(fromString value: String, commaAsSeparator: Bool = false) {
        var parsedValue = ""
        if commaAsSeparator {
            parsedValue = value.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
        } else {
            parsedValue = value.replacingOccurrences(of: ",", with: ".")
        }
        
        if let valid = Decimal(string: parsedValue) {
            self = valid
        } else {
            self = 0
        }
    }
    
    func toBrazilianRealString(commaAsSeparator: Bool = true, withDollarSymbol: Bool = false) -> String {
        let formatter = NumberFormatter()
        if commaAsSeparator {
            formatter.locale = Locale(identifier: "pt_BR")
        } else {
            formatter.locale = Locale(identifier: "en_US")
        }
        formatter.numberStyle = .currency
        if withDollarSymbol {
            formatter.currencySymbol = "R$"
        } else {
            formatter.currencySymbol = ""
        }
        
        if let cur = formatter.string(for: self) {
            return cur
        }
        return ""
    }
}


extension TimeInterval {
    func string(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }

}
