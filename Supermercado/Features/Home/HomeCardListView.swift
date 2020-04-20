//
//  HomeCardView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 07/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

let homeItems: [HomeItem] = [
        HomeItem(imageBackgroung: "image_woman", icon: "ic_list", text: "Minhas\nlistas"),
        HomeItem(imageBackgroung: "image_woman_left", icon: "ic_location", text: "Mercados\npróximos a mim")
]

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

struct HomeCardListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardListView()
    }
}

struct CardImageOverlay: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: 34, height: 44)
            Text(text)
                .font(Font.system(size: 16))
                .fontWeight(.medium)
                .padding(6)
                .foregroundColor(.white)
        }
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(6)
    }
}


struct HomeItem: Identifiable {
    let id: UUID = UUID()
    var imageBackgroung: String
    var icon: String
    var text: String
}

