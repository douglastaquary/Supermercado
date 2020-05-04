//
//  SupermarketItemCell.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 25/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketItemCell: View {
    @EnvironmentObject var supermarketService: SupermarketService
    var supermarketItem: SupermarketItem
    var supermarketID: Cart.ID
    var imageName = ""
    
    @State var isDone = false

    var body: some View {
        
        Button(action: {
            self.isDone.toggle()
        }) {
            HStack {
                SupermarketItemThumbnail(supermarketItem: supermarketItem)
                VStack(alignment: .leading) {
                    Text(supermarketItem.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(8)
                    Text("R$ \(supermarketItem.price)")
                        .font(.caption)
                        .foregroundColor(.primary)
                         .padding(8)
                    
                }
                Spacer()
                Image(systemName: self.$isDone.wrappedValue ? "checkmark" : "")
                
            }
        }
        .frame(height: 68)
    }
}

struct SupermarketItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketItemCell(supermarketItem: SupermarketItem(), supermarketID: UUID())
    }
}
