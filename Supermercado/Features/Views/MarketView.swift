//
//  MarketView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 15/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct MarketView: View {
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                VStack(alignment:.leading, spacing: 4) {
                    Text("Empório Cosset")
                        .font(.system(size: 16, weight: .medium, design: .default))
                    Text("• 10 min - 750 m")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(Color("primary"))
                    Text("R. das Ameixeiras,\n400 - Jabaquara, São Paulo")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(Color.secondary)
                }
                Spacer()
                Text("Como chegar")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(Color("buttonAction"))

                    

            }
            Rectangle()
                .foregroundColor(Color("DividerColor"))
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}
