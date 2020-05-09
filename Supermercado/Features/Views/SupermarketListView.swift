//
//  SupermarketListView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketListView: View {
    @EnvironmentObject var supermarketService: SupermarketService
    @ObservedObject var viewModel: SupermarketListViewModel
    
    @State private var editMode = EditMode.inactive
    @State private var showPopover: Bool = false
    @State private var countList: Int = 0
    @State private var loadingData: Bool = false
    @State private var showFooterView: Bool = false
    
    @State private var itemsToRemove: [UUID] = []

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
                                countItems: self.viewModel.count,
                                imageName: self.viewModel.cart.iconName.rawValue
                            )
                            ForEach(self.supermarketService.performSections(to: self.viewModel.cart.id)) { section in
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

        //.onAppear(perform: self.performShoppingList)
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .white
        }
        .navigationBarItems(
            trailing:
            
            HStack(spacing: 24) {
                Button(action: {
                    //self.showPopover = true
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
    
    private func performShoppingList() {
        self.loadingData = true
        self.supermarketService.updateSections(to: self.viewModel.cart.id) { result in
            switch result {
            case .success(let shopping):
                self.viewModel.sections = shopping
                self.loadingData.toggle()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
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
        return SupermarketListButtonFooter(
            removeAction: {
                self.showFooterView = false
            }, editAction: {
                self.showFooterView = false
            }, showEditManagerView: $showFooterView
        )
    }
}

struct SupermarketListView_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketListView(viewModel: SupermarketListViewModel(cart: Cart(name: "List View", iconName: .beef), supermarketService: SupermarketService())).environment(\.colorScheme, .dark)
    }
}
