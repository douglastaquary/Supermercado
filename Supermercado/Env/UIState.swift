//
//  UIState.swift
//  Supermercado
//
//  Created by Douglas Taquary on 26/08/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import SwiftUI

class UIState: ObservableObject {
    enum Tab: Int {
        case carts, nearest
    }
    
    enum Route {
        case cart(cart: Cart)
        case shopping(item: SupermarketItem)
        
        func makeDetailView() -> some View {
            switch self {
            case let .cart(cart):
                return AnyView(CardView(cart: cart, showEditMode: .constant(false)))
            case let .shopping(item):
                return AnyView(Text("Screen SupermarketSetupView"))
            }
        }
    }
    
    @Published var selectedTab = Tab.carts
    @Published var route: Route?
    @Published var routeEnabled = false
}

