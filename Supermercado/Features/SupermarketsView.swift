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
        return List(supermarkets) { supermarket in
            NavigationLink(
                destination: SupermarketDetailView(viewModel: SupermarketDetailViewModel(supermarket: supermarket)).environmentObject(self.supermarketService),
                label: { SupermarketCell(supermarket: supermarket).environmentObject(self.supermarketService) }
            )
        }
        .navigationBarTitle(Text("Home"))
        .navigationBarItems(
            trailing: Button(
                action: {
                    withAnimation {
                        self.showEditView.toggle()
                        self.supermarketService.addNewSupermarket()
                    }
                }
            ) {
                Image(systemName: "plus.circle.fill")
            }.sheet(isPresented: $showEditView) {
                Text("Edit cart")
                //CartEditView(viewModel: CartEditViewModel())
            }
        )
    
    }
}

struct SupermarketsViewPreview : PreviewProvider {
    static var previews: some View {
        SupermarketsView()
    }
}
