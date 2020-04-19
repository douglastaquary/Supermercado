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
    
    var cartData: [Cart] = [
        Cart(name: "Churrasco do\nbeto", iconName: "churras"),
        Cart(name: "Churrasco do\nbeto", iconName: "churras"),
        Cart(name: "Churrasco do\nbeto", iconName: "churras"),
        Cart(name: "Churrasco do\nbeto", iconName: "churras"),
        Cart(name: "Churrasco do\nbeto", iconName: "churras"),
        Cart(name: "Churrasco do\nbeto", iconName: "churras"),
        Cart(name: "Churrasco do\nbeto", iconName: "churras")
    ]

    var carts: [Cart] = []
    
    @State var showAddCartView = false

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea([.all])
            VStack {
                ASCollectionView(
                    data: self.cartData,
                    dataID: \.self
                ) { cart, _ in
                   CardGridView(cart: cart)
                }
                .contentInsets(.init(top: 20, left: 0, bottom: 20, right: 0))
                .layout {
                    .grid(layoutMode: .adaptive(withMinItemSize: 175),
                          itemSpacing: 2,
                          lineSpacing: 8,
                          itemSize: .absolute(198))
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
                    AddCartView()
                }
                .padding()
            }
        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .white
            UITableView.appearance().separatorColor = .clear
        }
        .navigationBarTitle(Text("Minhas listas"), displayMode: .inline)
        .accentColor(.black)
        .navigationBarColor(.white)
    }

    private func list(of carts: [Cart]) -> some View {
        return List {
            ForEach(0..<carts.count/2) { _ in
                HStack(alignment: .center) {
                    ForEach(carts) { cart in
                        CardGridView(cart: cart)
                    }
                }
            }
        }
    }
    
//    func destinationForItem(_ cart: Cart) -> some View
//    {
//        ScrollView {
//            PostView(post: item)
//                .onAppear {
//                    ASRemoteImageManager.shared.load(item.url)
//                    ASRemoteImageManager.shared.load(item.usernamePhotoURL)
//                }
//        }
//        .navigationBarTitle("", displayMode: .inline)
//    }
}

struct CartListView_Previews: PreviewProvider {
    static var previews: some View {
        CartListView(carts: [])
  
    }
}

