//
//  SupermarketSetupView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 10/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import Combine

struct SupermarketSetupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var supermarketService: SupermarketService
    @ObservedObject var viewModel: SupermarketSetupViewModel
    @Binding var ids: [UUID]
    
    @State private var modalPresented: Bool = false
    @State private var nameSujestionText: String = ""
    @State private var amountText: String = ""
    @State private var howMuchText: String = ""
    @State private var measureText: String = ""
    @State private var selectedCategory: Int = 0
    @State private var isFocused: Bool = false
    @State private var showPopover: Bool = false
    
    @State private var showSheet: Bool = false
    @State private var showPhotoOptions: Bool = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State fileprivate var pickerMode: PickerMode = .category

    var body: some View {
        VStack {
            ZStack {
                Color.systemBackground.edgesIgnoringSafeArea([.all])
                Rectangle()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                )
                    .foregroundColor(Color.label)
                    .opacity(self.modalPresented ? 0.5 : 0)
                    .animation(.easeOut)
                    .onTapGesture {
                        self.isFocused = false
                        self.hideKeyboard()
                        self.modalPresented.toggle()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Spacer()
                    nameTextField()
                    ImagePlaceholderView(image: self.image)
                        .onTapGesture {
                            self.showSheet = true
                            self.hideKeyboard()
                    }
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Selecione uma imagem"), message: Text(""), buttons: [
                            .default(Text("Galeria de fotos")) {
                                // open photo library
                                self.showPhotoOptions = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Câmera")) {
                                // open camera
                                self.showPhotoOptions = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                    }
                    
                    HStack(spacing: 16) {
                        amountTextField()
                            .onTapGesture {
                                self.isFocused = true
                                self.modalPresented = false
                            }
                        
                        categoryView()
                            .onTapGesture {
                                self.pickerMode = .category
                                self.hideKeyboard()
                                self.modalPresented = true
                                self.isFocused = true
                            }
                        
                    }
                    .padding(.top, 32)
                    
                    HStack(spacing: 16) {
                        howMuchTextField()
                            .onTapGesture {
                                self.isFocused = true
                                self.modalPresented = false

                            }
                        measureView()
                             .onTapGesture {
                                 self.modalPresented = false
                                 self.isFocused = true
                             }
                    }
                    Spacer()
                    
                    Button(action: {
                        self.setPngDataRecord()
                        self.presentationMode.wrappedValue.dismiss()
                        self.addNewShoppingIfNeeded()
                        haptic(.success)
                    }, label: {
                        Text("Confirmar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("primary"))
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                    })
                    .disabled(!viewModel.isValid)
                    .opacity(!viewModel.isValid ? 0.6 : 1)
                    .padding(.bottom, 64)
                }
                .padding()
                .onTapGesture {
                    self.isFocused = false
                }
                presentSheet()
                
            }
            .onTapGesture {
                self.isFocused = false
            }
            .sheet(isPresented: $showPhotoOptions) {
                ImagePicker(
                    image: self.$image,
                    isShown: self.$showPhotoOptions,
                    sourceType: self.sourceType
                )
                
            }
            .onAppear {
                UINavigationBar.appearance().backgroundColor = .white
                self.viewModel.categoryName = Mock.Setup.categories[self.selectedCategory].tipo
                self.viewModel.performEditModeIfNeeded(to: self.ids)
            }
            .navigationBarTitle(Text("Adicionar item"), displayMode: .inline)
            .accentColor(.black)
            .navigationBarColor(.systemBackground)
            .keyboardAdaptive()
        }
        
    }
    
    func addNewShoppingIfNeeded() {
        if ids.count == 1 {
            if let shopping = self.viewModel.supermarketItem {
                self.supermarketService.updateShopping(
                    for: self.viewModel.cartID,
                    with: shopping
                )
            }

        } else {
            if let shopping = self.viewModel.supermarketItem {
                self.supermarketService.addItem(
                    for: self.viewModel.cartID,
                    with: shopping
                )
            }
        }

    }
    
    private func setPngDataRecord() {
        self.viewModel.supermarketItem?.avatarJPEGData = self.image?.pngData()

    }
    
    private func amountTextField() -> some View {
        return VStack {
            HStack {
                TextField("Quantos itens?", text: $viewModel.amount)
                    .font(.body)
                    .foregroundColor(.label)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .keyboardType(.numbersAndPunctuation)
                
                Image("ic_down")
                    .accentColor(Color.primary)
                    .frame(width: 28, height: 28)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
        }
    }
    
    private func howMuchTextField() -> some View {
        let howMuchText = Binding<String>(get: { () -> String in
            let valueString = "\(self.viewModel.value)"
            let decimalResult = Decimal(
                fromString: valueString
            ).toBrazilianRealString(withDollarSymbol: true)
            
            return decimalResult
        }) { (string) in
            var string = string
            string.removeAll { (c) -> Bool in
                !c.isNumber
            }
            self.viewModel.howMuchText = string
        }
        
        return VStack {
            HStack {
                TextField("Quanto custa?", text: howMuchText)
                    .font(.body)
                    .foregroundColor(.label)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .keyboardType(.numbersAndPunctuation)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
        }
    }
    
    private func nameTextField() -> some View {
        return VStack(alignment: .leading) {
            TextField("Qual produto deseja adicionar?", text: $viewModel.supermarketName)
                .disabled(self.viewModel.disableTextField)
                .font(.body)
                .foregroundColor(.label)
                .frame(maxWidth: .infinity, maxHeight: 24)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
            HStack {
                Text(self.viewModel.supermarketMessage)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("secondaryText"))
                    .font(.subheadline)
            }
        }
    }

    private func categoryView() -> some View {
        return VStack {
            HStack {
                Text(Mock.Setup.categories[self.selectedCategory].tipo)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .foregroundColor(.label)
                Image("ic_down")
                    .accentColor(Color.primary)
                    .frame(width: 28, height: 28)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1.2)
                .foregroundColor(Color("secondaryText"))
        }
        .padding(.bottom, 4)
    }
    
    
    private func measureView() -> some View {
        return VStack {
            HStack {
                TextField("Medida", text: $viewModel.measureName)
                    .font(.body)
                    .foregroundColor(.label)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .keyboardType(.alphabet)
            }
            
            Rectangle()
                .foregroundColor(Color("secondaryText"))
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            Text("Ex.: 500g, 10 metros")
                .font(.body)
                .foregroundColor(Color("secondaryText"))
        }
        .padding(.top, 26)
    }
    
    private func presentSheet() -> some View {
        // The Sheet View
        return VStack(spacing: 0) {
            VStack {
                RoundedRectangle(cornerRadius: CGFloat(5.0) / 2.0)
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color("secondaryText"))
                Spacer()
            }
            .frame(height: 6)
            .padding(.top)
            
            VStack {
                HStack {
                    Button(action: {
                        self.modalPresented.toggle()
                    }, label: {
                        Text("Cancelar")
                            .frame(height: 28)
                            .foregroundColor(Color("buttonAction"))
                    })
                        .onTapGesture {
                            self.isFocused = true
                    }
                    Spacer()
                    Button(action: {
                        if self.pickerMode == .category {
                            self.viewModel.categoryName = Mock.Setup.categories[self.selectedCategory].tipo
                        }
                        self.modalPresented.toggle()
                        
                    }, label: {
                        Text("Concluído")
                            .frame(height: 28)
                            .foregroundColor(Color("buttonAction"))
                    })
                        .onTapGesture {
                            self.isFocused = true
                    }
                }
                .padding([.leading, .trailing])
                
                if self.pickerMode == PickerMode.category {
                    Picker(selection: $selectedCategory, label: Text("")) {
                        ForEach(0..<Mock.Setup.categories.count) { index in
                            Text(Mock.Setup.categories[index].tipo)
                                .tag(index)
                                .foregroundColor(.label)
                        }
                    }
                    .foregroundColor(.primary)
                    .labelsHidden()
                }
            }
            
            Spacer()
        }
            
        .frame(width: UIScreen.main.bounds.width, height: 444)
        .background(colorScheme == .light ?  Color.white : Color.black)
        .cornerRadius(20)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .offset(y: self.modalPresented ? 330 : 720)
        .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
}

struct SupermarketSetupView_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketSetupView(viewModel: SupermarketSetupViewModel(cartID: UUID(), setupPresentationMode: .adding), ids: .constant([]))//.environment(\.colorScheme, .dark)
    }
}

