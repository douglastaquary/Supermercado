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
    
    @State var showEditView = false

    var body: some View {
        
        Button(action: { self.showEditView.toggle() }) { // Button to show the modal view by toggling the state
            HStack {
                SupermarketItemThumbnail(supermarketItem: supermarketItem)
                VStack(alignment: .leading) {
                    Text(supermarketItem.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
        }.sheet(isPresented: $showEditView) { // Passing the state to the sheet API
            SupermarketEditView(supermarketID: self.supermarketID, supermarketItem: self.supermarketItem)
                .environmentObject(self.supermarketService)
        }
    }
}

struct SupermarketItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketItemCell(supermarketItem: SupermarketItem(), supermarketID: UUID())
    }
}
