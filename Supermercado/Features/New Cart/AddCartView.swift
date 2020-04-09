//
//  AddCartView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct AddCartView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showAddCartView = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    Spacer()
                    CartTextField(text: "")
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
        }.accentColor(.black)
    }
}

struct AddCartView_Previews: PreviewProvider {
    static var previews: some View {
        AddCartView()
    }
}

struct CartTextField: View {
    
    @State var text: String
    
        var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                TextField("Digite o nome da lista", text: $text)
                    .font(.body)
                    .foregroundColor(Color("secondaryText"))
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


