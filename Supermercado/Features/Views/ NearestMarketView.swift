//
//   NearestMarketView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 15/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import MapKit

struct NearestMarketView: View {

    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Locais próximos a você")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                    .padding(.leading)
                MapView(centerCoordinate: $centerCoordinate)
                    
            }
            .frame(height: 196)

            VStack(alignment: .leading) {
                
                HStack() {
                    Image("icon_chevron")
                        .frame(width: 26, height: 24)
                }.frame(maxWidth: .infinity)
                
                Text("06 lugares encontrados")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom)
                ForEach(0..<6) { _ in
                    MarketView()
                }
                //.padding()
//                ScrollView {
//                    ForEach(0..<6) { _ in
//                        MarketView()
//                    }
//                }.padding()
            }
            .padding()
        }

    }
}

struct NearestMarketView_Previews: PreviewProvider {
    static var previews: some View {
        NearestMarketView()
    }
}