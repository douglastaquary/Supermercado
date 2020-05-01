//
//  CartEditView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 31/03/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CartEditView: View {

    @EnvironmentObject var supermarketService: SupermarketService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var cart: Cart = Cart(name: "Cart Edit", iconName: .party)
    @State var showEditView = false
            
    var body: some View {
        NavigationView {
            form()
        }
    }
    
    private func form() -> some View {
        return Form {
                Section(header: Text("Dê um nome para o seu novo carrinho de compras")) {
                    TextField("Nome", text: $cart.name)
                        .font(.largeTitle)
                }
                .font(.body)
            }
            .navigationBarTitle(Text(cart.name))
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
                        self.supermarketService.addNewCart(self.cart)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ) {
                    Text("Salvar")
                }
            )
    }
}

struct CartEditView_Previews: PreviewProvider {
    static var previews: some View {
        CartEditView()
    }
}
