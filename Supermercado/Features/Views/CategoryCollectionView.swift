//
//  CategoryCollectionView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CategoryCollectionView: View {
    
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            List {
                ForEach(0..<2) { _ in
                    HStack(spacing: 24) {
                        ForEach(0..<3) { _ in
                            CategoryGridView(
                                iconName: "ic_shopping_cart"
                            )
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }

        }
    }
}

struct CategoryCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCollectionView()
    }
}

struct CategoryGridView: View {
    var iconName: String

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                CircleCategoryOverlay(iconName: iconName)
                Text("Compras\ndo mês")
                    .foregroundColor(Color("CategoryTextColor"))
                    .font(Font.system(size: 14))
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .frame(height: 42)
            }
        }
    }
}


struct CircleCategoryOverlay: View {
    var iconName: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("categoryOverlay"))
            HStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 42, height: 42)
            }
        }
        .frame(width: Metrics.circleOverlayHeight, height: Metrics.circleOverlayHeight, alignment: .center)
    }
}
