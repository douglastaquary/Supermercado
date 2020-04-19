//
//  SupermarketView.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 25/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import Combine

/// Detail view for a Contact
struct SupermarketItemView: View {
    @EnvironmentObject var supermarketService: SupermarketService
    
    @State var supermarketItem: SupermarketItem = SupermarketItem()
    @State var showEditView = false
    @State private var selectedCategory = 2
    @State private var selectedQntd = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var supermarketID: Supermarket.ID
    
//    private var currencyFormatter: NumberFormatter = {
//        let f = NumberFormatter()
//        // allow no currency symbol, extra digits, etc
//        f.isLenient = true
//        f.numberStyle = .currency
//        return f
//    }()
//
    var body: some View {
        NavigationView {
            form()
        }
    }
    
    private func form() -> some View {
        return Form {
                Section(header: Text("Informações sobre o item do carrinho ")) {
                    TextField("Nome", text: $supermarketItem.name)
                        .font(.body)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    TextField("Valor", text: $supermarketItem.price)
                        .font(.body)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
//                    TextField("Quantidade", text: $supermarketItem.amount)
//                        .font(.body)
//                        .padding()
//                        .background(Color.white)
//                        .foregroundColor(Color.black)
//                        .multilineTextAlignment(.leading)
                    
                }
                .font(.body)
//                Section(header: Text("Categoria. Ex.: Limpeza, bebida")) {
//                    Picker(
//                        selection: $selectedCategory,
//                        label: Text("Selecione uma categoria"),
//                        content: {
//                            ForEach(0..<self.categories.count) { index in
//                                Text(categories[index].tipo).tag(index)
//                            }
//                        }
//                    )
//                }
//                Section(header: Text("Unidade de medida. Ex.: Kg, ml, metro")) {
//                    Picker(
//                        selection: $selectedQntd,
//                        label: Text("Selecione uma medida"),
//                        content: {
//                            ForEach(0..<medidas.count) { index in
//                                Text(medidas[index].tipo).tag(index)
//                            }
//                        }
//                    ).pickerStyle(WheelPickerStyle())
//                }
            }
            .navigationBarTitle(Text(supermarketItem.name))
            .navigationBarItems(
                leading: Button(action: {
                        withAnimation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                ){
                    Text("Cancelar")
                },
                trailing:
                    Button(action: {
                        self.supermarketService.addItem(for: self.supermarketID, with: self.supermarketItem)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ) {
                    Text("Salvar")
                }
            )
    }
}


///// Detail view for a Contact
//struct SupermarketView: View {
//    @EnvironmentObject var viewModel: SupermarketViewModel
//    var supermarketID: Supermarket.ID
//
//    /// Binding used to track edits. When a field is edited, it triggers an update
//    /// to this binding, which passes the change directly to the viewModel, and thus
//    /// the store
//    var supermarket: Binding<Supermarket> {
//        Binding<Supermarket>(
//            get: { () -> Supermarket in
//                self.viewModel.supermarketService.supermarket(withID: self.supermarketID)
//            },
//            set: { supermarket in
//                self.viewModel.supermarketService.update(supermarket)
//            }
//        )
//    }
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Name")) {
//                    TextField("Nome", text: supermarket.name)
//                    TextField("Endereço", text: supermarket.address.streetAddress)
//                }
//                Section(header: Text("Address")) {
//                    TextField("Street Address", text: supermarket.address.streetAddress)
//                    TextField("City", text: supermarket.address.city)
//                    TextField("Country", text: supermarket.address.country)
//                }
//            }
//            .navigationBarTitle(Text("Item"))
//        }
//    }
//}
//
//

