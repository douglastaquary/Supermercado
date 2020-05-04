//
//  AddCartView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import Combine
import ASCollectionView


struct AddCartView: View {
    
    @EnvironmentObject var supermarketService: SupermarketService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = NewCartViewModel()
    
    @State var tapCategory: ((String) -> Void)?
    @State var showAddCartView = false
    
    @State var iconName: IconName = .undefined

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
                    ZStack(alignment: .leading) {
                        ASCollectionView(
                            data: viewModel.categories,
                            dataID: \.self
                        ) { category, index in
                            
                            ZStack {
                                Button(action: {
                                    self.iconName = category.iconName
                                    self.viewModel.categorySelected(on: category)
                                }, label: {
                                    VStack(alignment: .center) {
                                        ZStack {
                                            if category.isSelected {
                                                Circle()
                                                    .stroke(Color("buttonAction"), lineWidth: 1)
                                                
                                            } else {
                                                Circle()
                                                    .foregroundColor(Color.secondarySystemBackground)
                                            }

                                            HStack {
                                                Image(category.iconName.rawValue)
                                                    .resizable()
                                                    .renderingMode(.template)
                                                    .foregroundColor(Color("buttonAction"))
                                                    .frame(width: 42, height: 42)
                                            }
                                        }
                                        .onTapGesture {
                                            haptic(.warning)
                                            self.viewModel.categorySelected(on: category)
                                        }
                                        .frame(width: Metrics.circleOverlayHeight, height: Metrics.circleOverlayHeight, alignment: .center)
                                        Text(category.categotyTitle)
                                            .foregroundColor(Color.primary)
                                            .font(Font.system(size: 14))
                                            .lineLimit(nil)
                                            .multilineTextAlignment(.center)
                                            .frame(height: 42)
                                    }
                                }).buttonStyle(PlainButtonStyle())
                            }
                        }
                        .contentInsets(.init(top: 24, left: 0, bottom: 24, right: 0))
                        .layout {
                            .grid(layoutMode: .adaptive(withMinItemSize: 112),
                                  itemSpacing: 24,
                                  lineSpacing: 60,
                                  itemSize: .absolute(100))
                        }

                    }
                    .foregroundColor(Color.tertiarySystemBackground)

                    Button(action: {
                        self.supermarketService.addNewCart(self.viewModel.cart)
                        self.presentationMode.wrappedValue.dismiss()
                        haptic(.success)
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


