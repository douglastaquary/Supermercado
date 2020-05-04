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
