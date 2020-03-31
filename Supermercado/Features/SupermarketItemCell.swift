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
    var supermarketID: Supermarket.ID
    
    var body: some View {
        NavigationLink(
            destination:
            SupermarketItemView(supermarketID: self.supermarketID)
                .environmentObject(self.supermarketService)
        ) {
            HStack {
                SupermarketItemThumbnail(supermarketItem: supermarketItem)
                VStack(alignment: .leading) {
                    Text(supermarketItem.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
struct SupermarketItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketItemCell(supermarketItem: SupermarketItem(), supermarketID: UUID())
    }
}
