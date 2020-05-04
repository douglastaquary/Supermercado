//
//  SectionTextView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 27/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SectionTextView: View {
    
    var title: String
    
        var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.medium)
                    .font(Font.system(size: 16))
            }
        }
        .padding()
    }
}

struct SectionTextView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTextView(title: "Custom header")
    }
}
