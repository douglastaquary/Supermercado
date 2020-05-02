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
    
    var body: some View {
        NavigationLink(destination:
            SupermarketListView(
                viewModel: SupermarketListViewModel(cart: cart)
            ).environmentObject(self.supermarketService)
        ) {
            ZStack {
                Color.systemBackground.edgesIgnoringSafeArea([.all])
                Rectangle()
                    .cornerRadius(4)
                    .foregroundColor(.tertiarySystemBackground)
                    .frame(width: 156, height: 186, alignment: .center)
                    .shadow(radius: 5, x: 0, y: 5).opacity(0.4)
                VStack(alignment: .center) {
                    Image(cart.iconName.rawValue)
                        .resizable()
                        .foregroundColor(Color("buttonAction"))
                        .frame(width: 40, height: 40, alignment: .center)
                    Text(cart.name)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.label)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    Text("\(cart.items.count) itens adicionados")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(8)
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                }
            }
        }
    }
}

struct CardGridView_Previews: PreviewProvider {
    static var previews: some View {
        CardGridView(cart: Cart(name: "Churrasco do\nBeto", iconName: .party))
        .environment(\.colorScheme, .dark)
    }
}
