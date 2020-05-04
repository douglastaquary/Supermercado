////
////  TextButtonOverlay.swift
////  Supermercado
////
////  Created by Douglas Taquary on 08/04/20.
////  Copyright © 2020 Douglas Taquary. All rights reserved.
////
//
import SwiftUI

struct TextButtonOverlay: View {
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 4
            )
            .accentColor(Color("primary"))
            
            HStack {
                Text(title)
                    .font(Font.system(size: 16))
                    .padding(6)
                    .foregroundColor(.white)
            }
        }
        
    }
}

struct TextButtonOverlay_Previews: PreviewProvider {
    static var previews: some View {
        TextButtonOverlay(title: "Click")
    }
}
