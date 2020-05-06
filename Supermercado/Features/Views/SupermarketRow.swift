//
//  SupermarketRow.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketRow: View {
    @EnvironmentObject var supermarketService: SupermarketService
    
    var supermarketItem: SupermarketItem
    var cartID: Cart.ID
    var imageName = ""
    
    
    var body: some View {
        VStack {
            HStack {
                if self.supermarketItem.avatarJPEGData != nil {
                    Image(uiImage: UIImage(data:self.supermarketItem.avatarJPEGData!)!)
                        .resizable()
                        .frame(width: 56, height: 56)
                }

                VStack(alignment: .leading) {
                    Text(supermarketItem.name)
                        .foregroundColor(.label)
                        .font(.body)
                        .strikethrough(supermarketItem.isDone ?? false)
                    HStack {
                        HStack {
                            Text("Qnt:")
                                .foregroundColor(.label)
                                .font(.body)
                                .strikethrough(supermarketItem.isDone ?? false)
                            Text(supermarketItem.amount)
                                .foregroundColor(.label)
                                .font(.body)
                                .fontWeight(.bold)
                                .strikethrough(supermarketItem.isDone ?? false)
                        }
                        Spacer()
                        if !supermarketItem.price.isEmpty {
                            Text(supermarketItem.price)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("buttonAction"))
                            .strikethrough(supermarketItem.isDone ?? false)
                        }
                    }
                    .padding(.top, 8)
                }
                
            }
            
            Rectangle()
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, maxHeight: 1)

        }
        .foregroundColor(.tertiarySystemBackground).opacity((supermarketItem.isDone ?? false) ? 0.4 : 1)
        .frame(height: 76)
    }
    
}

struct SupermarketRow_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketRow(supermarketItem: SupermarketItem(), cartID: UUID())
    }
}
