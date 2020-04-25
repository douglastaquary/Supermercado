//
//  SupermarketRow.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketRow: View {
    var body: some View {
        VStack {
            HStack {
                Image("picanha")
                    .resizable()
                    .frame(width: 56, height: 56)
                VStack(alignment: .leading) {
                    Text("Picanha Maturatta Friboi - 2kg")
                        .foregroundColor(.label)
                        .font(.body)
                    HStack {
                        HStack {
                            Text("Qnt:")
                                .foregroundColor(.label)
                                .font(.body)
                            Text("2")
                                .foregroundColor(.label)
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        Text("R$ 97,80")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("buttonAction"))
                    }
                    .padding(.top, 8)
                }
                
            }
            
            Rectangle()
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, maxHeight: 1)

        }
        .foregroundColor(.tertiarySystemBackground)
        .frame(height: 76)
    }
    
}

struct SupermarketRow_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketRow()
    }
}
