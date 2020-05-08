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
    @ObservedObject var viewModel: CartListViewModel = CartListViewModel()

    @State var showAddCartView = false
    @State var showOptions = false
    @State var loadingData = false
    @State var isReady = false
    @State var showingAlert = false
    @State var loadingdata = false
    @State var cartToRemove: Cart?
    
    @State var carts: [Cart] = []

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
                        CardGridView(cart: cart, isRedyToRemove: self.$isReady) { cart in
                            self.cartToRemove = cart
                            self.showingAlert = true
                        }.environmentObject(self.supermarketService)
                            
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
            
            if loadingData {
                ActivityIndicatorView()
            }
            
            if showingAlert {
                CustomAlertView(
                    titleLabel: "Remover lista",
                    bodyLabel: "Tem certeza que deseja remover a lista \(cartToRemove?.name ?? "")?",
                    callToActionLeftButton: "Não",
                    callToActionRightButton: "Sim",
                    leftAction: {
                        self.isReady = false
                        self.showingAlert = false
                        self.cartToRemove = nil
                    }, rightAction: {
                        self.showingAlert = false
                        self.isReady = false
                        self.loadingData = true
                        if self.cartToRemove != nil {
                            self.performDeleteCart(id: self.cartToRemove?.id ?? UUID())
                        }
                        //self.performDeleteCart(id: self.cartToRemove?.id ?? UUID())
                    },
                    showingModal: self.$showingAlert
                )
            }
        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .white
        }
        .navigationBarItems(
            trailing: Button(action: {
                self.showOptions = true
            }, label: {
                Image("ic_option")
                    .foregroundColor(.label)
                })
                .frame(width: 24, height: 24)
            )
        .navigationBarTitle(Text("Minhas listas"), displayMode: .inline)
        .accentColor(.black)
        .navigationBarColor(.systemBackground)
        .popover(isShowing: $showOptions) {
            self.isReady = true
        }
        .onAppear(perform: self.fetchCarts)
    }
    
    private func fetchCarts() {
        self.viewModel.carts = self.supermarketService.carts
    }
    
    func performDeleteCart(id: Cart.ID) {
        self.supermarketService.deleteCart(withID: id) { result in
            switch result {
            case .success(_):
                self.loadingData = false
                self.cartToRemove = nil
                //self.fetchCarts()
            case .failure(let error):
                self.loadingData = false
                self.cartToRemove = nil
                print(error.localizedDescription)
            }
        }
    }
    
}

struct CartListView_Previews: PreviewProvider {
    static var previews: some View {
        CartListView().environment(\.colorScheme, .dark)
  
    }
}

