//
//  PrimaryButton.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//
//
//import SwiftUI
//
//struct PrimaryButton: Button {
//    
//    var didTapButtonAction: (()-> Void)?
//    
//    var body: some View {
//        
//        Button(action: {
//            self.showAddCartView.toggle()
//        }) {
//           ZStack {
//                RoundedRectangle(
//                    cornerRadius: 4
//                )
//                .accentColor(Color("primary"))
//                HStack {
//                    Text("Criar lista")
//                        .font(Font.system(size: 16))
//                        .padding(6)
//                        .foregroundColor(.white)
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: 48)
//            .padding(10)
//            
//        }.sheet(isPresented: $showAddCartView) {
//            AddCartView()
//        }
//        
////        Button(action: {
////            self.didTapButtonAction?()
////        }) {
////          Text("Hello, World!")
////        }
//        
//    }
//}
//
//struct PrimaryButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PrimaryButton()
//    }
//}
