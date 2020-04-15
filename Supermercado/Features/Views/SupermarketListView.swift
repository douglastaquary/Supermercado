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
    
    init() {
        UINavigationBar.appearance().backgroundColor = .white
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Section(header: InformationHeaderView()) {
                        Section(header: TitleHeader(title: "Carnes")) {
                            List {
                                ForEach(0..<2) { item in
                                    SupermarketRow()
                                }
                            }
                        }
                    }
                }
            }
            .cornerRadius(4)
            .shadow(color: Color("DividerColor"),radius: 4, x: 0, y: 4)
            .padding()
            newSupermarketButon()
        }
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
//
//
//
//
//            Button(action: {
//            self.showAddCartView.toggle()
//        }, label: {
//            Text("Nova lista")
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color("primary"))
//                .foregroundColor(Color.white)
//                .cornerRadius(4)
//        })
        .padding()
    }
}

struct SupermarketListView_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketListView()
    }
}
