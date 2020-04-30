//
//  Mock.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation


struct Mock {
    
    struct Home {
        static let homeItems: [HomeItem] = [
                HomeItem(imageBackgroung: "image_woman", icon: "ic_list", text: "Minhas\nlistas"),
                HomeItem(imageBackgroung: "image_woman_left", icon: "ic_location", text: "Mercados\npróximos a mim")
        ]
        
    }
    
    struct CartList {
        static let carts: [Cart] = [
            Cart(name: "Churrasco do\nbeto", iconName: "festas"),
            Cart(name: "Churrasco do\nbeto", iconName: "festas"),
            Cart(name: "Churrasco do\nbeto", iconName: "festas"),
            Cart(name: "Churrasco do\nbeto", iconName: "festas"),
            Cart(name: "Churrasco do\nbeto", iconName: "festas"),
            Cart(name: "Churrasco do\nbeto", iconName: "festas"),
            Cart(name: "Churrasco do\nbeto", iconName: "festas")
        ]
    }
    
    struct Setup {
        static let measures: [Measure] = [
                Measure(tipo: "Kilo"),
                Measure(tipo: "Metro"),
                Measure(tipo: "Litro"),
                Measure(tipo: "Milímetro"),
                Measure(tipo: "Centímetro")
        ]
        
        static let categories: [Category] = [
                Category(tipo: "Cama, mesa e banho"),
                Category(tipo: "Limpeza"),
                Category(tipo: "Bebidas"),
                Category(tipo: "Grãos"),
                Category(tipo: "Legumes e verduras"),
                Category(tipo: "Carnes"),
                Category(tipo: "Outros")
        ]
    }
}
