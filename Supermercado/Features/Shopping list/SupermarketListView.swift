//
//  SupermarketListView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketListView: View {
    //private var collection = UserCollection.shared
    @ObservedObject var viewModel: SupermarketListViewModel
    
    @State private var editMode = EditMode.inactive
    @State private var showPopover: Bool = false
    @State private var countList: Int = 0
    @State private var loadingData: Bool = false
    @State private var showFooterView: Bool = false
    @State private var headerItemsCount: Int = 0
    
    @State private var itemsToRemove: [Int] = []

    var body: some View {
        VStack {
            ZStack {
                Color.systemBackground.edgesIgnoringSafeArea([.all])
                ScrollView(showsIndicators: false) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(4)
                            .foregroundColor(.tertiarySystemBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(radius: 5, x: 0, y: 5).opacity(0.4)
                            .padding()
                        VStack {
                            InformationHeaderView(
                                titleHeader: self.viewModel.cart.name,
                                countItems: $headerItemsCount,//self.supermarketService.listItemCount(to: viewModel.cart.id),
                                imageName: self.viewModel.cart.iconName.rawValue
                            )
                            ForEach(UserCollection.shared.performSections(to: viewModel.cart.id)) { section in
                                TitleHeader(title: section.name)
                                ForEach(section.items) { item in
                                    SupermarketRow(
                                        supermarketItem: item,
                                        cartID: self.viewModel.cart.id,
                                        showEditMode: self.$showFooterView,
                                        actionTapRow: { item in
                                            if self.showFooterView {
                                                let items = self.itemsToRemove.filter { $0 == item.id }
                                                if items.isEmpty {
                                                    self.itemsToRemove.append(item.id)
                                                } else {
                                                    self.itemsToRemove.removeAll(where: { $0 == item.id })
                                                }
                                            }
                                        }
                                    )
                                }
                            }
                        }
                        .padding(32)
                    }
                }
                
                if loadingData {
                    ActivityIndicatorView()
                }
            }
            
            if !loadingData {
                installFooterViewIfNeeded()
            }
            
        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .white
            self.updateHeaderCount()
        }
        .navigationBarItems(
            trailing:
            
            HStack(spacing: 24) {
                Button(action: {
                    self.showFooterView = true
                }, label: {
                Image("ic_more")
                    .foregroundColor(Color("buttonAction"))
                    .rotationEffect(.degrees(showFooterView ? 90 : 0))
                    .animation(.default)
                })
                
                Button(action: {
                    print("DEBUG: - Share list!")
                }, label: {
                Image("ic_share")
                    .foregroundColor(Color("buttonAction"))
                })
            }


        )
        .navigationBarTitle(Text(self.viewModel.cart.name), displayMode: .inline)
        .accentColor(.black)
        .navigationBarColor(.systemBackground)
    }
    
   
    private func installFooterViewIfNeeded() -> some View {
        return VStack {
            Rectangle()
                .foregroundColor(.secondarySystemBackground)
                .frame(height: 1)
                .offset(y: -8)

            if showFooterView {
                installFooterManagerView().animation(.default)

            } else {
                NavigationLink(destination: SupermarketSetupView(viewModel: SupermarketSetupViewModel(
                    cartID: self.viewModel.cart.id,
                    supermarketItem: SupermarketItem()
                    )
                )) {
                    Text("Adicionar item")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("primary"))
                        .foregroundColor(Color.white)
                        .cornerRadius(4)
                        .animation(.default)
                        //.transition(.opacity)
                        //.scaleEffect()

                }
                .padding()
            }
        }
    }
    
    private func installFooterManagerView() -> some View {
        return EditManagerFooterView(
            removeAction: {
                self.showFooterView = false
                self.remove(ids: self.itemsToRemove)
            }, editAction: {
                self.showFooterView = false
            }, showEditManagerView: $showFooterView
        )
    }
    
    
    func remove(ids: [Int]) {
        _ = UserCollection.shared.performDeleteItems(for: viewModel.cart.id, with: ids)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.updateHeaderCount()
            })
        
    }
    
    private func updateHeaderCount() {
        self.headerItemsCount = UserCollection.shared.listItemCount(to: self.viewModel.cart.id)
    }

}

struct SupermarketListView_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketListView(viewModel: SupermarketListViewModel(cart: Cart(name: "List View", iconName: .beef))).environment(\.colorScheme, .dark)
    }
}
