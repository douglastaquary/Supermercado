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
        ZStack {
            Image("image_woman")
                .resizable()
                .cornerRadius(4)
                .overlay(
                    CardImageOverlay(
                        imageName: "ic_list",
                        text: "Minhas\nlistas"),
                        alignment: .leading
                    )
                
        }
        .frame(height: 104)
    }
}


import SwiftUI

struct NearestMarketCardView: View {
    
    var body: some View {
        ZStack {
            Image("image_woman_left")
                .resizable()
                .cornerRadius(4)
                .overlay(
                    CardImageOverlay(
                        imageName: "ic_location",
                        text: "Mercados\npróximos a mim"),
                        alignment: .leading
                    )
                
        }
        .frame(height: 104)
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
            Text(text)
                .font(Font.system(size: 16))
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

