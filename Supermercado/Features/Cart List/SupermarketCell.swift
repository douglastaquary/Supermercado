//
//  SupermarketCell.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 19/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketCell: View {
    @EnvironmentObject var supermarketService: SupermarketService
    var supermarket: Cart

    var body: some View {
        HStack {
            SupermarketThumbnail(supermarket: supermarket)
            VStack(alignment: .leading) {
                Text(supermarket.name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
//        NavigationLink(destination:
//            SupermarketDetailView(viewModel: SupermarketListViewModel(supermarket: supermarket))
//                .environmentObject(self.supermarketService)
//        ) {
//            HStack {
//                SupermarketThumbnail(supermarket: supermarket)
//                VStack(alignment: .leading) {
//                    Text(supermarket.name)
//                        .font(.headline)
//                        .foregroundColor(.primary)
//                }
//            }
//        }
    }
}

struct SupermarketThumbnail: View {
    var supermarket: Cart
    var body: some View {
        var image: Image
        if let data = supermarket.avatarJPEGData {
            image = Image(uiImage: UIImage(data:data)!)
        } else {
            image = Image(systemName: "cart")
        }
        return image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(4.0)
            .frame(width: 40, height: 40, alignment: .center)
            .foregroundColor(.green)
    }
}

struct SupermarketItemThumbnail: View {
    var supermarketItem: SupermarketItem
    var body: some View {
        var image: Image
        if let data = supermarketItem.avatarJPEGData {
            image = Image(uiImage: UIImage(data:data)!)
        } else {
            image = Image(systemName: "cart")
        }
        return image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(4.0)
            .frame(width: 40, height: 40, alignment: .center)
            .foregroundColor(.green)
    }
}
