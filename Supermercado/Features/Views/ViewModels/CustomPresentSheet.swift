//
//  CustomPresentSheet.swift
//  Supermercado
//
//  Created by Douglas Taquary on 02/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CustomPresentSheet: View {
    
    @State var pickerMode: PickerMode = .category
    @State var selectedCategory: Int = 0
    @State var selectedMeasure: Int = 0
    @Binding var showingModal: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color.secondary.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
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
                        Button(action: { self.showingModal = false }, label: {
                            Text("Cancelar")
                                .frame(height: 24)
                                .foregroundColor(Color("buttonAction"))
                        })
                            .onTapGesture {
//                                self.isFocused = true
//                                self.hideKeyboard()
                        }
                        Spacer()
                        Button(action: {
                            if self.pickerMode == .category {
                               // self.viewModel.categoryName = Mock.Setup.categories[self.selectedCategory].tipo
                            }
                            self.showingModal.toggle()
                            
                        }, label: {
                            Text("Concluído")
                                .frame(height: 24)
                                .foregroundColor(Color("buttonAction"))
                        })
                            .onTapGesture {
//                                self.isFocused = true
//                                self.hideKeyboard()
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    
                    if self.pickerMode == PickerMode.category {
                        Picker(selection: $selectedCategory, label: Text("")) {
                            ForEach(0..<Mock.Setup.categories.count) { index in
                                Text(Mock.Setup.categories[index].tipo).tag(index)
                                    .foregroundColor(.label)
                            }
                        }
                        .frame(height: 120)
                        .foregroundColor(.primary)
                        .labelsHidden()
                    } else {
                        Picker(selection: $selectedMeasure, label: Text("")) {
                            ForEach(Mock.Setup.measures) { measure in
                                Text(measure.tipo).tag(measure)
                                    .foregroundColor(.label)
                            }
                        }
                        .frame(height: 120)
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
            .offset(y: self.showingModal ? 330 : 720)
            .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
        }
    }
}

struct CustomPresentSheet_Previews: PreviewProvider {
    static var previews: some View {
        CustomPresentSheet(showingModal: .constant(true))
    }
}

