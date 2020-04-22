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
                    HStack(spacing: 36) {
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
        .foregroundColor(Color.tertiarySystemBackground)
    }
}

struct CategoryCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCollectionView()
    }
}

struct CategoryGridView: View {
    var iconName: String
    @State var isTapped: Bool = false

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                CircleCategoryOverlay(iconName: iconName, isTapped: isTapped)
                Text("Compras\ndo mês")
                    .foregroundColor(Color.primary)
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
    @State var isTapped: Bool = false

    var body: some View {
        ZStack {
            if isTapped {
                Circle()
                    .stroke(Color("buttonAction"), lineWidth: 1)
                
            } else {
                Circle()
                    .foregroundColor(Color.secondarySystemBackground)
            }

            HStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 42, height: 42)
            }
        }
        .onTapGesture {
            haptic(.success)
            self.isTapped.toggle()
            
        }
        .frame(width: Metrics.circleOverlayHeight, height: Metrics.circleOverlayHeight, alignment: .center)
    }
}
