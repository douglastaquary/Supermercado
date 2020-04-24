//
//  CategoryCollectionView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 08/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import ASCollectionView

struct CategoryCollectionView: View {
    
    var viewModel: [CartCategory] = []
    public var tapCategory: ((CartCategory) -> Void)?
    
    init(viewModel: [CartCategory]) {
        self.viewModel = viewModel
        UITableView.appearance().separatorColor = .clear
    }

    var body: some View {
        ZStack(alignment: .leading) {
            ASCollectionView(
                data: self.viewModel,
                dataID: \.self
            ) { category, index in
                CategoryGridView(
                    category: category
                )
            }
            .contentInsets(.init(top: 24, left: 0, bottom: 24, right: 0))
            .layout {
                .grid(layoutMode: .adaptive(withMinItemSize: 112),
                      itemSpacing: 24,
                      lineSpacing: 60,
                      itemSize: .absolute(100))
            }

        }
        .foregroundColor(Color.tertiarySystemBackground)
    }
}

struct CategoryCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCollectionView(viewModel: [])
    }
}

struct CategoryGridView: View {
    var category: CartCategory
    
    @State var isTapped: Bool = false

    var body: some View {
        ZStack {
            Button(action: {
                print("DEBUG: tap on category with ID: \(self.category.id)")
            }, label: {
                VStack(alignment: .center) {
                    CircleCategoryOverlay(category: category)
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
                Image(category.iconName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("buttonAction"))
                    .frame(width: 42, height: 42)
            }
        }
        .onTapGesture {
            print("\nDEBUG: tap on `CircleCategoryOverlay` with ID: \(self.category.id)")
            haptic(.success)
            self.isTapped.toggle()
            
        }
        .frame(width: Metrics.circleOverlayHeight, height: Metrics.circleOverlayHeight, alignment: .center)
    }
}
