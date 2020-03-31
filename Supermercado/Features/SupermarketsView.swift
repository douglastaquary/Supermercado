//
//  SupermarketsView.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 19/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import UIKit

/// A list of Supermarkets.
struct SupermarketsView : View {
    @EnvironmentObject var supermarketService: SupermarketService
    
    @State var showEditView = false
    
    private func thumbnail(for supermarket: Supermarket) -> Image {
        if let data = supermarket.avatarJPEGData {
            return Image(uiImage: UIImage(data:data)!)
        } else {
            return Image(systemName: "cart")
        }
    }
    
    var body: some View {
        NavigationView {
            list(of: supermarketService.supermarkets)
        }
    }
    
    private func list(of supermarkets: [Supermarket]) -> some View {
        return List {
                ForEach(supermarkets) { supermarket in
                    SupermarketCell(supermarket: supermarket).environmentObject(self.supermarketService)
                }.onDelete { indices in
                    indices.forEach {
                        self.supermarketService.deleteSupermarket(withID: self.supermarketService.supermarkets[$0].id)
                    }
                }
            }
            .navigationBarTitle(Text("Meus carrinhos"))
            .navigationBarItems(
                trailing: Button(
                    action: {
                        withAnimation {
                            self.showEditView.toggle()
                        }
                    }
                ) {
                    Image(systemName: "plus.circle.fill")
                }.sheet(isPresented: $showEditView) {
                    CartEditView().environmentObject(self.supermarketService)
                }
            )
    }
    
}

struct SupermarketsViewPreview : PreviewProvider {
    static var previews: some View {
        SupermarketsView()
    }
}
