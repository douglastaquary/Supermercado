//
//  SupermarketDetailView.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 25/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import LLVS

struct SupermarketDetailView: View {
    
    @State var showEditView = false
    
    @EnvironmentObject var supermarketService: SupermarketService
    var viewModel: SupermarketDetailViewModel
//
//    /// Binding used to track edits. When a field is edited, it triggers an update
//    /// to this binding, which passes the change directly to the viewModel, and thus
//    /// the store
//    private var supermarketItem: Binding<SupermarketItem> {
//        Binding<SupermarketItem>(
//            get: { () -> SupermarketItem in
//                self.viewModel.fetchItem(for: self.supermarketID, with: self.viewModel.uuid)
//            },
//            set: { newSupermarket in
//                self.viewModel.updateItem(for: self.supermarketID, with: self.viewModel.supermarketItem)
//            }
//        )
//    }
//
//    private var supermarket: Binding<Supermarket> {
//        Binding<Supermarket>(
//            get: { () -> Supermarket in
//                self.viewModel.supermarket(withID: self.supermarketID)
//            },
//            set: { newSupermarket in
//                self.viewModel.update(newSupermarket)
//            }
//        )
//    }
//    
    var body: some View {
        list(of: supermarketService.fetchItems(for: viewModel.supermarket.id))

//        NavigationView {
//            list(of: supermarketService.fetchItems(for: viewModel.supermarket.id))
//        }
    }
    
    private func list(of items: [SupermarketItem]) -> some View {
        return List {
            ForEach(supermarketService.fetchItems(for: viewModel.supermarket.id)) { item in
                SupermarketItemCell(supermarketItem: item, supermarketID: self.viewModel.supermarket.id)
                    .environmentObject(self.supermarketService)
                
            }.onDelete { indices in
                indices.forEach {
                    self.viewModel.deleteItem(for: self.viewModel.supermarket.id, with: self.viewModel.items[$0])
                }
            }
        }
        .navigationBarTitle(Text("Home"))
        .navigationBarItems(
            trailing: Button(
                action: {
                    withAnimation {
                        self.showEditView.toggle()
                        self.supermarketService.addNewSupermarket()
                    }
            }
            ) {
                Image(systemName: "plus.circle.fill")
            }.sheet(isPresented: $showEditView) {
                Text("Edit cart")
                SupermarketItemView(supermarketID: self.viewModel.supermarket.id)
                    .environmentObject(self.supermarketService)
                //CartEditView(viewModel: CartEditViewModel())
            }
        )
    }
}

