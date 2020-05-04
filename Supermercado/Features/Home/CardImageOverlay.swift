//
//  CardImageOverlay.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//


import SwiftUI

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


