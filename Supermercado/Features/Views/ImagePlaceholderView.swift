//
//  ImagePlaceholderView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 10/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct ImagePlaceholderView: View {
    
    var image: UIImage? = nil
        
    var body: some View {
        VStack {
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .frame(width: 112, height: 112)
                .foregroundColor(Color("secondaryText"))
                .overlay(
                    VStack {
                        if self.image != nil {
                            Image(uiImage: self.image ?? UIImage(named: "")!)
                            
                                .resizable()
                                .frame(width: 112, height: 112)
                        } else {
                            Image("ic_placeholder")
                                .frame(width: 30, height: 40)
                            Text("Adicione uma foto do produto")
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .accentColor(.secondary)
                        }

                    }
                )
        }
    }
}

struct ImagePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceholderView()
    }
}
