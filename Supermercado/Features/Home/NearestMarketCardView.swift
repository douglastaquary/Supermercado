//
//  NearestMarketCardView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//


import SwiftUI

struct NearestMarketCardView: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image("image_woman_left")
                .resizable()
                .renderingMode(.original)
                .cornerRadius(4)
            Rectangle()
                .foregroundColor(Color("CardMask2")).opacity(0.3)
            CardImageOverlay(
                imageName: "ic_location",
                text: "Mercados\npróximos a mim"
            )
                
        }
        .frame(height: 124)
    }
}


struct NearestMarketCardView_Previews: PreviewProvider {
    static var previews: some View {
        NearestMarketCardView()
    }
}
