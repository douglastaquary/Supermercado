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
            Cart(name: "Churrasco do\nbeto", iconName: .party),
            Cart(name: "Churrasco do\nbeto", iconName: .beef),
            Cart(name: "Churrasco do\nbeto", iconName: .fastShopping),
            Cart(name: "Churrasco do\nbeto", iconName: .pet),
            Cart(name: "Churrasco do\nbeto", iconName: .shopping),
            Cart(name: "Churrasco do\nbeto", iconName: .vegetables),

        ]
    }
    
    struct Setup {
        static let measures: [Measure] = [
                Measure(tipo: "Kilo(Kg)"),
                Measure(tipo: "Metro(m)"),
                Measure(tipo: "Litro(l)"),
                Measure(tipo: "Grama(g)"),
                Measure(tipo: "Unidade"),
                Measure(tipo: "Milímetro(ml)"),
                Measure(tipo: "Centímetro(cm)")
        ]
        
        static let categories: [Category] = [
                Category(index: 0, tipo: "Cama, mesa e banho"),
                Category(index: 1, tipo: "Limpeza"),
                Category(index: 2, tipo: "Bebidas"),
                Category(index: 3, tipo: "Grãos"),
                Category(index: 4, tipo: "Legumes e verduras"),
                Category(index: 5, tipo: "Carnes"),
                Category(index: 6, tipo: "Outros")
        ]
    }
}
