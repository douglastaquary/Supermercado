//
//  SupermarketListButtonFooter.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketListButtonFooter: View {
    @Environment(\.colorScheme) var colorScheme
    
    var removeAction: () -> Void
    var editAction: () -> Void
    
    @Binding var showEditManagerView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.showEditManagerView.toggle()
                    self.removeAction()
                    
                }) {
                    Text("Remover")
                        .foregroundColor(Color("buttonAction"))
                        .frame(height: 16)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    self.showEditManagerView.toggle()
                }) {
                    Text("Cancelar")
                        .foregroundColor(.secondary)
                        .frame(height: 16)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    self.showEditManagerView.toggle()
                    self.editAction()
                }) {
                    Text("Editar")
                        .foregroundColor(Color("buttonAction"))
                        .frame(height: 16)
                        .padding()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 72)
        .background(colorScheme == .light ?  Color.white : Color.black)
        //.offset(y: self.showEditManagerView ? 360 : 720)
//        .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
    }
}

struct SupermarketListButtonFooter_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketListButtonFooter(removeAction: {}, editAction: {}, showEditManagerView: .constant(true))
    }
}
