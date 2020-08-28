//
//  CardView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 07/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @State var cart: Cart
    @State var didTapped: Bool = false
    @Binding var showEditMode: Bool
    @State var actionTappedCard: ((Cart) -> Void)?
    
    var body: some View {
        ZStack {
            Color.systemBackground.edgesIgnoringSafeArea([.all])
            Rectangle()
                .cornerRadius(4)
                .foregroundColor(.tertiarySystemBackground)
                .frame(width: 156, height: 186, alignment: .center)
                .shadow(radius: 5, x: 0, y: 5).opacity(0.4)
            
            if self.showEditMode {
                HStack {
                    Image(showEditMode && didTapped ? "ic_check" : "ic_check_empty")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 24, height: 24, alignment: .center)
                }
                .frame(maxWidth: 156, maxHeight: 256)
                .padding(.trailing, -108)
                .padding(.top, -140)
                .onTapGesture {
                    self.didTapped.toggle()
                    self.actionTappedCard?(self.cart)
                }
            }
            
            VStack(alignment: .center) {
                Image(cart.iconName.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("buttonAction"))
                    .frame(width: 40, height: 40, alignment: .center)
                Text(cart.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.label)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                Text(cart.items.count > 1 ? "\(cart.items.count) itens adicionados" : "\(cart.items.count) item adicionado")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
            }
        }

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            cart: Cart(name: "Churrasco do\nBeto", iconName: .party),
            showEditMode: .constant(true)
        )
    }
}
