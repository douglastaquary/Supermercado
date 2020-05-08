//
//  CardGridView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CardGridView: View {
    @EnvironmentObject var supermarketService: SupermarketService
    var cart: Cart
    @Binding var isRedyToRemove: Bool
    @State var isReadyToRemoveAction: (Cart) -> Void
    
    var body: some View {
        VStack {
            if isRedyToRemove {
                CardView(
                    cart: cart,
                    isRedyToRemove: $isRedyToRemove,
                    isReadyToRemoveAction: isReadyToRemoveAction
                )
            } else {
                NavigationLink(destination:
                    SupermarketListView(
                        viewModel: SupermarketListViewModel(cart: cart, supermarketService: supermarketService)
                    ).environmentObject(self.supermarketService)
                ) {
                    CardView(cart: cart, isRedyToRemove: $isRedyToRemove, isReadyToRemoveAction: isReadyToRemoveAction)
                }
            }
        }
    }

}

struct CardGridView_Previews: PreviewProvider {
    static var previews: some View {
        CardGridView(
            cart: Cart(name: "Churrasco do\nBeto", iconName: .party),
            isRedyToRemove: .constant(true),
            isReadyToRemoveAction: { _ in }
        )
        //.environment(\.colorScheme, .dark)
    }
}
