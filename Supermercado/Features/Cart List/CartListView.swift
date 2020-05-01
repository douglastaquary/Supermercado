//
//  CartListView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import ASCollectionView

struct CartListView: View {
    @EnvironmentObject var supermarketService: SupermarketService

    @State var showAddCartView = false

    var body: some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea([.all])
            VStack {
                
                if self.supermarketService.carts.isEmpty {
                    EmptyStateView()
                } else {
                    ASCollectionView(
                        data: self.supermarketService.carts,
                        dataID: \.self
                    ) { cart, _ in
                       CardGridView(cart: cart)
                            .environmentObject(self.supermarketService)
                    }
                    .contentInsets(.init(top: 20, left: 0, bottom: 20, right: 0))
                    .layout {
                        .grid(layoutMode: .adaptive(withMinItemSize: 175),
                              itemSpacing: 2,
                              lineSpacing: 8,
                              itemSize: .absolute(198))
                    }
                }

                Button(action: {
                    self.showAddCartView.toggle()
                }, label: {
                    Text("Nova lista")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("primary"))
                        .foregroundColor(Color.white)
                        .cornerRadius(4)
                })
                .sheet(isPresented: $showAddCartView) {
                    AddCartView().environmentObject(self.supermarketService)
                }
                .padding()
            }
        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .white
        }
        .navigationBarTitle(Text("Minhas listas"), displayMode: .inline)
        .accentColor(.black)
        .navigationBarColor(.systemBackground)
    }

}

struct CartListView_Previews: PreviewProvider {
    static var previews: some View {
        CartListView().environment(\.colorScheme, .dark)
  
    }
}

