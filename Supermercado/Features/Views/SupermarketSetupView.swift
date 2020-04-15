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
    
    @State private var modalPresented: Bool = false
    @State private var nameSujestionText: String = ""
    @State private var amountText: String = ""
    @State private var howMuchText: String = ""
    @State private var categoryText: String = ""
    @State private var selectedCategory: Int = 0
    @State private var selectedMeasure: Int = 0
    @State private var isFocused: Bool = false
    
    @State private var showSheet: Bool = false
    @State private var showPhotoOptions: Bool = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera

    fileprivate enum PickerMode {
        case measure
        case category
    }
    
    @State fileprivate var pickerMode: PickerMode = .category
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        //NavigationView {
            ZStack {
                Rectangle()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                    .edgesIgnoringSafeArea(.all)
                    .opacity(self.modalPresented ? 0.5 : 0)
                    .animation(.easeOut)
                    .onTapGesture {
                        self.isFocused = false
                        self.hideKeyboard()
                        self.modalPresented.toggle()
                    }
                    
                VStack(alignment: .leading, spacing: 16) {
                    CustomTextField(text: nameSujestionText)
                        
                    ImagePlaceholderView(image: self.image)
                        .onTapGesture {
                            self.showSheet = true
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
                        AmountItemTextField(amountText: self.amountText)
                            .onTapGesture {
                                self.isFocused = true
                            }
                            
                        Button(action: {
                            self.modalPresented.toggle()
                            self.pickerMode = .category
                        }, label: {
                            CategoryTextField(
                                categoryString: categories[selectedCategory].tipo
                            )
                        })
                        .onTapGesture {
                            self.isFocused = true
                        }

                    }
                    .padding(.top, 32)
                    
                    HStack(spacing: 16) {
                        HowMuchTextField(howMuchText: self.howMuchText)
                            .onTapGesture {
                                self.isFocused = true
                            }
                        Button(action: {
                            self.modalPresented.toggle()
                            self.pickerMode = .measure
                        }, label: {
                            MeasureTextFieldWithSubtitle(
                                title: medidas[selectedMeasure].tipo,
                                exampleDecription: "Ex.: 500g, 10 metros"
                            )
                            .onTapGesture {
                                self.isFocused = true
                            }
                        })

                    }

                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        print("DEBUG: - Did add new item in cart 🎉")
                    }, label: {
                        Text("Confirmar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("primary"))
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                    })
                    .padding(.top, 64)

                }
                .padding()
                .onTapGesture {
                    self.isFocused = false
                    self.hideKeyboard()
                }
                presentSheet()
           // }
            
        }
                .onReceive(Just(selectedCategory)) { value in
                    self.categoryText = categories[value].tipo
                    print("\(value)\(self.categoryText)") // Just one step can monitor the @state value.
                }
                .onTapGesture {
                    self.isFocused = false
                    self.hideKeyboard()
            }
            .sheet(isPresented: $showPhotoOptions) {
                ImagePicker(image: self.$image, isShown: self.$showPhotoOptions, sourceType: self.sourceType)
        }
        
    }
    
    /// The height of the handler bar section
    private var handlerSectionHeight: CGFloat {
        return 4
    }
    
    private func presentSheet() -> some View {
        // The Sheet View
        return VStack(spacing: 0) {
                // This is the little rounded bar (handler) on top of the sheet
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
                                .foregroundColor(Color("buttonAction"))
                        })
                        .onTapGesture {
                            self.isFocused = true
                            self.hideKeyboard()
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.modalPresented.toggle()
                            print(categories[self.selectedCategory].tipo)
                            self.categoryText = categories[self.selectedCategory].tipo
                        }, label: {
                            Text("Ok")
                                .foregroundColor(Color("buttonAction"))
                        })
                        .onTapGesture {
                            self.isFocused = true
                            self.hideKeyboard()
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    
                    if self.pickerMode == PickerMode.category {
                        Picker(selection: $selectedCategory, label: Text("")) {
                            ForEach(0..<categories.count) { index in
                                Text(categories[index].tipo).tag(index)
                            }
                        }
                        .frame(height: 120)
                        .labelsHidden()
                    } else {
                        Picker(selection: $selectedMeasure, label: Text("")) {
                            ForEach(medidas) { medida in
                                Text(medida.tipo).tag(medida)
                            }
                        }
                        .frame(height: 120)
                        .labelsHidden()
                        }
                    }
                    
                Spacer()
            }

            .frame(width: UIScreen.main.bounds.width, height: 444)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            .offset(y: self.modalPresented ? 340 : 720)
            .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
    }
    
}

struct SupermarketSetupView_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketSetupView()
    }
}



struct CustomTextField: View {
    
    @State var text: String
    @State var isFocused: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                TextField("Qual produto deseja adicionar?", text: $text)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 16)

                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color("secondaryText"))
                Text("0 de 60")
                    .foregroundColor(Color("secondaryText"))
                    .font(.body)
            }
        }
    }
}


struct AmountItemTextField: View {
    
    @State var amountText: String
    
    var body: some View {
        VStack {
            HStack {
                TextField("Quanto itens?", text: $amountText)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .keyboardType(.numberPad)
                    
                Image("ic_down")
                    .accentColor(Color("secondaryColor"))
                    .frame(width: 28, height: 28)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
        }
        
        
    }
}

struct HowMuchTextField: View {
    
    @State var howMuchText: String
    
    var body: some View {
        VStack {
            HStack {
                TextField("Quanto custa?", text: $howMuchText)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .keyboardType(.numberPad)
                    
                Image("ic_down")
                    .accentColor(Color("secondaryColor"))
                    .frame(width: 28, height: 28)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
        }
        
        
    }
}


struct CategoryTextField: View {
    
    @State var categoryString: String
    
    var body: some View {
        VStack {
            HStack {
                TextField("Categoria", text: $categoryString)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .accentColor(Color.primary)
                    .disabled(true)
                Image("ic_down")
                    .accentColor(Color.primary)
                    .frame(width: 28, height: 28)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
        }
    }

}


struct MeasureTextFieldWithSubtitle: View {
    
    @State var title: String
    var exampleDecription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Medida", text: $title)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                    .disabled(true)
                    .accentColor(Color.primary)
                Image("ic_down")
                    .accentColor(Color.primary)
                    .frame(width: 28, height: 28)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
            Text(exampleDecription)
                .font(.body)
                .foregroundColor(Color("secondaryText"))
        }
        .padding(.top, 26)
        
        
    }
}


struct PickerEditView: View {
    
    @State var text: String
    var exampleText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("", text: $text)
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 24)
                Image("ic_down")
                    .frame(width: 28, height: 28)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color("secondaryText"))
            Text(exampleText)
                .font(.body)
                .foregroundColor(Color("secondaryText"))
        }
        .padding(.top, 26)
        
        
    }
}

