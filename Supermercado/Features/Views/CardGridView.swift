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
    @State var actionTappedCard: (Cart) -> Void
    @Binding var showEditMode: Bool
    
    var body: some View {
        VStack {
            if showEditMode {
                CardView(
                    cart: cart,
                    showEditMode: $showEditMode,
                    actionTappedCard: actionTappedCard
                )
            } else {
                NavigationLink(destination:
                    SupermarketListView(
                        viewModel: SupermarketListViewModel(cart: cart)
                    ).environmentObject(self.supermarketService)
                ) {
                    CardView(
                        cart: cart,
                        showEditMode: $showEditMode,
                        actionTappedCard: actionTappedCard
                    )
                }
            }
        }
    }

}

struct CardGridView_Previews: PreviewProvider {
    static var previews: some View {
        CardGridView(
            cart: Cart(name: "Churrasco do\nBeto", iconName: .party),
            actionTappedCard: { _ in },
            showEditMode: .constant(true)
        )
    }
}
