//
//  HomeView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 07/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var collection: UserCollection
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 146)
                        .foregroundColor(Color("primary"))
                    list()
                        .padding(.top, -36)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .accentColor(Color.primary)
        .foregroundColor(.tertiarySystemBackground)
    }
    
    private func list() -> some View {
        return ScrollView {
            NavigationLink(destination:
                CartListView() //.environmentObject(collection)
            ) {
                HomeCardListView()
            }
            NavigationLink(destination: NearestMarketView()) {
                NearestMarketCardView()
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.colorScheme, .dark)
    }
}



