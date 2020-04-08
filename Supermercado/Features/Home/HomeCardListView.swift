//
//  HomeCardView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 07/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct HomeCardListView: View {
    var homeItem: HomeItem
    var body: some View {
        ZStack {
            Image(homeItem.imageBackgroung)
                .resizable()
                .overlay(
                    CardImageOverlay(
                        imageName: homeItem.icon,
                        text: homeItem.text),
                        alignment: .leading
                    )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius:4,
                        style: .continuous
                    )
                )
        }
        .frame(height: 104)
    }
}

struct HomeCardListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardListView(homeItem: HomeItem(imageBackgroung: "image_woman", icon: "ic_list", text: "Minhas\nlistas"))
    }
}

struct CardImageOverlay: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(imageName)
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

