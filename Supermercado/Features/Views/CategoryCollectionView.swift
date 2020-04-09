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
        List {
            ForEach(0..<2) { _ in
                HStack(alignment: .center) {
                    ForEach(0..<3) { _ in
                        CategoryGridView(iconName: "ic_shopping_cart")
                            .padding()
                    }
                }
            }
        }
//        .listStyle(GroupedListStyle())
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
            VStack {
                CircleCategoryOverlay(iconName: iconName)
                Text("Compras\ndo mês")
                .foregroundColor(Color("secondaryText"))
                    .font(Font.system(size: 14))
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
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
            }
        }
            
        .frame(width: Metrics.circleOverlayHeight, height: Metrics.circleOverlayHeight, alignment: .center)
    }
}
