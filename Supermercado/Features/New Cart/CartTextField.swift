//
//  CartTextField.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

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

struct CartTextField_Previews: PreviewProvider {
    static var previews: some View {
        CartTextField(text: "Test")
    }
}
