//
//  HomeCardView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 07/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI


struct HomeCardListView: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image("image_woman")
                .resizable()
                .renderingMode(.original)
                .cornerRadius(4)
            Rectangle()
                .foregroundColor(Color("CardMask1")).opacity(0.3)
            CardImageOverlay(
                imageName: "ic_list",
                text: "Minhas\nlistas"
            )
                
        }
        .frame(height: 124)
    }
}


struct HomeCardListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardListView()
    }
}

