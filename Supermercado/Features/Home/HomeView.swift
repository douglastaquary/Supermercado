//
//  HomeView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 07/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    let homeItems: [HomeItem] = [
            HomeItem(imageBackgroung: "image_woman", icon: "ic_list", text: "Minhas\nlistas"),
            HomeItem(imageBackgroung: "image_woman_left", icon: "ic_location", text: "Mercados\npróximos a mim")
    ]
    
    init() {
        UINavigationBar.appearance().backgroundColor = Metrics.primary
    }
    
    var body: some View {
        NavigationView {
            list(of: homeItems)
        }
        .navigationBarColor(Metrics.primary)
    }
    
    private func list(of items: [HomeItem]) -> some View {
        return List {
            ForEach(items) { item in
                HomeCardListView(homeItem: item)
            }
        }
        .listStyle(GroupedListStyle())
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



