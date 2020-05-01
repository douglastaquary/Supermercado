//
//  AddCartView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import Combine

struct AddCartView: View {
    
    @EnvironmentObject var supermarketService: SupermarketService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = NewCartViewModel()
    
    @State var showAddCartView = false

    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    Spacer()
                    cartTextField()
                    SectionTextView(title: "Escolha a categoria")
                    CategoryCollectionView(
                        viewModel: viewModel.categories
                    )
                    Button(action: {
                        self.supermarketService.addNewCart(self.viewModel.cart)
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Salvar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("primary"))
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                    })
                    .disabled(!self.viewModel.isValid)
                    .opacity(!self.viewModel.isValid ? 0.6 : 1)
                    .padding()
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                        withAnimation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                ){
                    Text("Cancelar")
                        .foregroundColor(Color("buttonAction"))
                },
                trailing:
                    Button(action: {
                        self.viewModel.cart.name = ""
                    }
                ) {
                    Text("Limpar")
                        .foregroundColor(Color("buttonAction"))
                }
            )
                .navigationBarTitle(Text("Criar lista"), displayMode: .inline)
        }
        .accentColor(.black)
    }
    
    private func cartTextField() -> some View {
        return ZStack {
            VStack(alignment: .leading) {
                TextField("Digite o nome da lista", text: $viewModel.cartname)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 38)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color("secondaryText"))
                Text(self.viewModel.cartMessage)
                    .foregroundColor(Color("secondaryText"))
                    .font(.body)
            }
        }
        .padding()
    }
    
}

struct AddCartView_Previews: PreviewProvider {
    static var previews: some View {
        AddCartView()
    }
}


