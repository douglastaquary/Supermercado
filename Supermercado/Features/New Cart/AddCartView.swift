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
                    CategoryCollectionView()
                    Button(action: {
                        self.showAddCartView.toggle()
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
                        self.presentationMode.wrappedValue.dismiss()
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
        AddCartView()//.environment(\.colorScheme, .dark)
    }
}

struct CartTextField: View {
    
    @State var text: String
    @State var errorMessage: String?
    
        var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                TextField("Digite o nome da lista", text: $text)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 38)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color("secondaryText"))
                Text("Ex: Compras para o escritório")
                    .foregroundColor(Color("secondaryText"))
                    .font(.body)
            }
        }
        .padding()
    }
}

struct SectionTextView: View {
    
    var title: String
    
        var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.medium)
                    .font(Font.system(size: 16))
            }
        }
        .padding()
    }
}
