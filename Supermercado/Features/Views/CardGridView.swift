//
//  CardGridView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CardGridView: View {
    
    var cart: Cart
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(4)
                .foregroundColor(.white)
                .frame(width: 156, height: 186, alignment: .center)
                .shadow(radius: 6).opacity(0.4)
            VStack(alignment: .center) {
                Image(cart.iconName)
                    .resizable()
                    .frame(width: 48, height: 48, alignment: .center)
                Text(cart.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Text("0 item adicionados")
                    .font(.caption)
                    .foregroundColor(Color("secondaryText"))
                    .multilineTextAlignment(.center)
                    .padding(8)
            }
        }
        
    }
}

struct CardGridView_Previews: PreviewProvider {
    static var previews: some View {
        CardGridView(cart: Cart(name: "Churrasco do\nBeto", iconName: "churras"))
    }
}
