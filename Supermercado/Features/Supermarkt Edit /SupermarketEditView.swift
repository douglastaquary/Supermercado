//
//  SupermarketEditView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 31/03/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketEditView: View {
    
    @EnvironmentObject var supermarketService: SupermarketService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var supermarketID: Cart.ID
    @State var supermarketItem: SupermarketItem
    @State var showEditView = false
    
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
//                Section(header: Text("Medida")) {
//                    Picker(
//                        selection: $supermarketItem.price,
//                        label: Text("Selecione a medida"),
//                        content: {
//                            ForEach(medidas) { medida in
//                                Text(medida.tipo).tag(medida)
//                            }
//                        }
//                    )
//                    
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

struct SupermarketEditView_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketEditView(supermarketID: UUID(), supermarketItem: SupermarketItem())
    }
}
