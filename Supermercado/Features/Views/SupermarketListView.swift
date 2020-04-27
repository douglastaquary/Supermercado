//
//  SupermarketListView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketListView: View {
    
    var supermarkets: [SupermarketItem] = []
    var rows: [SupermarketRow] = []
    
//    init() {
//        UINavigationBar.appearance().backgroundColor = .white
//    }
    
    var body: some View {
        
        VStack {
            ZStack {
                Color.systemBackground.edgesIgnoringSafeArea([.all])
                ScrollView(showsIndicators: false) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(4)
                            .foregroundColor(.tertiarySystemBackground)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(radius: 5, x: 0, y: 5).opacity(0.4)
                            .padding()
                        VStack {
                            InformationHeaderView()
                            TitleHeader(title: "Carnes")
                            
                            ForEach(0..<2) { item in
                                SupermarketRow()
                            }
                        }
                        .padding(32)
                    }
                }
            }
            
            newSupermarketButon()
        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .white
        }
        .navigationBarTitle(Text("Churrasco do beto"), displayMode: .inline)
        .accentColor(.black)
            
        .navigationBarColor(.systemBackground)

    }
    
    private func list(of items: [SupermarketItem]) -> some View {
        return List {
            ForEach(0..<2) { item in
                SupermarketRow()
            }
        }
        .cornerRadius(4)
        .foregroundColor(.white)
        .colorMultiply(.clear)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .shadow(radius: 4, x: 0, y: 3).opacity(0.4)
        .padding()
    }
    
    private func newSupermarketButon() -> some View {
        return NavigationLink(destination: SupermarketSetupView()) {
            Text("Adicionar item")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("primary"))
                .foregroundColor(Color.white)
                .cornerRadius(4)
        }
        .padding()
    }
}

struct SupermarketListView_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketListView().environment(\.colorScheme, .dark)
    }
}
