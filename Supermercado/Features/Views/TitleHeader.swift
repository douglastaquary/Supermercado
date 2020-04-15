//
//  TitleHeader.swift
//  Supermercado
//
//  Created by Douglas Taquary on 10/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct TitleHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 18))
            Spacer()

        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity)
    }
}

struct TitleHeader_Previews: PreviewProvider {
    static var previews: some View {
        TitleHeader(title: "Carnes")
        
    }
}
