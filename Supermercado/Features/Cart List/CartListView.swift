//
//  CartListView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CartListView: View {
    //@EnvironmentObject var collection: UserCollection   
    @ObservedObject var viewModel: CartListViewModel = CartListViewModel()
    
    @State var showAddCartView = false
    @State var showOptions = false
    @State var loadingData = false
    @State var isReady = false
    @State var showingAlert = false
    @State var loadingdata = false
    @State var cartToRemove: Cart?
    @State private var showFooterView: Bool = false
    @State private var cartIdsToRemove: [Int] = []
    @State var carts: [Cart] = []
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea([.all])
            VStack {
                if UserCollection.shared.carts.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout, spacing: 16) {
                            ForEach(UserCollection.shared.carts, id: \.self) { cart in
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
                            }
                        }
                        .padding(.top, 16)
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
        self.viewModel.carts = UserCollection.shared.carts
    }
    
    func deletCarts(to ids: [Int]) {
        UserCollection.shared.deleteCarts(to: ids)
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
                    AddCartView()
                }
                .padding()
            }
        }
    }
    
    
    private func installFooterManagerView() -> some View {
        return EditManagerFooterView(
            removeAction: {
                self.showFooterView = false
                self.deletCarts(to: self.cartIdsToRemove)
            }, editAction: {
                self.showFooterView = false
            }, showEditManagerView: $showFooterView
        )
    }
    
}

struct CartListView_Previews: PreviewProvider {
    static var previews: some View {
        CartListView().environment(\.colorScheme, .dark)
        
    }
}

