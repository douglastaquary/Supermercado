//
//  CategoryCollectionView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CategoryGridView: View {
    var category: CartCategory
    
    @State var isTapped: Bool = false

    var body: some View {
        ZStack {
            Button(action: {
                
                print("DEBUG: tap on category with ID: \(self.category.id)")
            }, label: {
                VStack(alignment: .center) {
                    //CircleCategoryOverlay(category: category, isTapped: self.isTapped)
                    Text(category.categotyTitle)
                        .foregroundColor(Color.primary)
                        .font(Font.system(size: 14))
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .frame(height: 42)
                }
            }).buttonStyle(PlainButtonStyle())
        }
    }
}


struct CircleCategoryOverlay: View {
    
    var category: CartCategory
    @State var isTapped: Bool

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
                Image(category.iconName.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("buttonAction"))
                    .frame(width: 42, height: 42)
            }
        }
        .onTapGesture {
            print("\nDEBUG: tap on CircleCategoryOverlay`category with ID: \(self.category.id)")
            haptic(.warning)
            self.isTapped.toggle()
        }
        .frame(width: Metrics.circleOverlayHeight, height: Metrics.circleOverlayHeight, alignment: .center)
    }
}
