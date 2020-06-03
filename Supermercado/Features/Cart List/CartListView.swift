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
    @State private var showFooterView: Bool = false
    @State private var cartIdsToRemove: [UUID] = []
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
                        CardGridView(
                            cart: cart,
                            actionTappedCard: { item in
                                if self.showFooterView {
                                    let items = self.cartIdsToRemove.filter { $0 == item.id }
                                    if items.isEmpty {
                                        self.cartIdsToRemove.append(item.id)
                                    } else {
                                        self.cartIdsToRemove.removeAll(where: { $0 == item.id })
                                    }
                                }
                            },
                            showEditMode: self.$showFooterView
                        )
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

                installFooterViewIfNeeded()
            }
            
            if loadingData {
                ActivityIndicatorView()
            }

        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .white
        }
        .navigationBarItems(
            trailing: Button(action: {
                self.showFooterView = true
            }, label: {
                Image("ic_option")
                    .foregroundColor(.label)
                    .rotationEffect(.degrees(showFooterView ? 90 : 0))
                    .animation(.default)
                })
                .frame(width: 28, height: 28)

            )
        .navigationBarTitle(Text("Minhas listas"), displayMode: .inline)
        .accentColor(.black)
        .navigationBarColor(.systemBackground)
        .onAppear(perform: self.fetchCarts)
    }
    
    private func fetchCarts() {
        self.viewModel.carts = self.supermarketService.carts
    }
    
    func deletCarts(to ids: [UUID]) {
        _ = supermarketService
            .deleteCarts(to: ids)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                print("\nUpdated Carts 🎉")
            })
        
    }
    
    private func installFooterViewIfNeeded() -> some View {
        return VStack {
            Rectangle()
                .foregroundColor(.secondarySystemBackground)
                .frame(height: 1)
                .offset(y: -8)

            if showFooterView {
                installFooterManagerView().animation(.easeOut)
            } else {
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
    }
    
    
    private func installFooterManagerView() -> some View {
        return EditManagerFooterView(showEditManagerView: self.$showFooterView, removeAction: {
            self.showFooterView = false
            self.deletCarts(to: self.cartIdsToRemove)
        }, content: AnyView(
                Button(action: {
                    self.showFooterView = false
                }) {
                    Text("Editar")
                        .foregroundColor(Color("buttonAction"))
                        .frame(height: 16)
                        .padding()
                     //   Text("Editar")
            }
            .padding()
        ))
    }
    
}

struct CartListView_Previews: PreviewProvider {
    static var previews: some View {
        CartListView().environment(\.colorScheme, .dark)
  
    }
}

