//
//  SupermarketDetailView.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 25/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import LLVS

//struct SupermarketDetailView: View {
//    
//    @State var showEditView = false
//    
//    @EnvironmentObject var supermarketService: SupermarketService
//    var viewModel: SupermarketListViewModel
//   
//    var body: some View {
//        list(of: supermarketService.fetchItems(for: viewModel.supermarket.id))
//    }
//    
//    private func list(of items: [SupermarketItem]) -> some View {
//        return List {
//            ForEach(items) { item in
//                SupermarketItemCell(supermarketItem: item, supermarketID: self.viewModel.supermarket.id)
//                    .environmentObject(self.supermarketService)
//            }.onDelete { indices in
//                indices.forEach {
//                    self.supermarketService.deleteItem(for: self.viewModel.supermarket.id, with: self.viewModel.items[$0])
//                }
//            }
//        }
//        .navigationBarTitle(self.viewModel.supermarket.name)
//        .navigationBarItems(
//            trailing: Button(
//                action: {
//                    withAnimation {
//                        self.showEditView.toggle()
//                    }
//                }
//            ) {
//                Image(systemName: "plus.circle.fill")
//            }.sheet(isPresented: $showEditView) {
//                SupermarketItemView(supermarketID: self.viewModel.supermarket.id)
//                    .environmentObject(self.supermarketService)
//                //CartEditView(viewModel: CartEditViewModel())
//            }
//        )
//    }
//}

