//
//  SupermarketView.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 25/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

/// Detail view for a Contact
struct SupermarketItemView: View {
    @EnvironmentObject var supermarketService: SupermarketService
    
    @State var supermarketItem: SupermarketItem = SupermarketItem()
    @State var showEditView = false
    
    var supermarketID: Supermarket.ID

    var body: some View {
        NavigationView {
            form()
        }
    }
    
    
    private func form() -> some View {
        return Form {
                Section(header: Text("Informações sobre o item do carrinho ")) {
                    TextField("Nome", text: $supermarketItem.name)
                    TextField("Valor", text: $supermarketItem.price)
                }
            }
        .navigationBarTitle(Text(supermarketItem.name))
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.supermarketService.addItem(for: self.supermarketID, with: self.supermarketItem)
                        self.showEditView.toggle()
                    }
                ) {
                    Text("Salvar")
                }
            )
    }
}



/// Detail view for a Contact
struct SupermarketView: View {
    @EnvironmentObject var viewModel: SupermarketViewModel
    var supermarketID: Supermarket.ID
    
    /// Binding used to track edits. When a field is edited, it triggers an update
    /// to this binding, which passes the change directly to the viewModel, and thus
    /// the store
    var supermarket: Binding<Supermarket> {
        Binding<Supermarket>(
            get: { () -> Supermarket in
                self.viewModel.supermarketService.supermarket(withID: self.supermarketID)
            },
            set: { supermarket in
                self.viewModel.supermarketService.update(supermarket)
            }
        )
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Nome", text: supermarket.name)
                    TextField("Endereço", text: supermarket.address.streetAddress)
                }
                Section(header: Text("Address")) {
                    TextField("Street Address", text: supermarket.address.streetAddress)
                    TextField("City", text: supermarket.address.city)
                    TextField("Country", text: supermarket.address.country)
                }
            }
            .navigationBarTitle(Text("Item"))
        }
    }
}



