//
//  SupermarketRow.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct SupermarketRow: View {
    
    var supermarketItem: SupermarketItem
    var cartID: Cart.ID
    var imageName = ""
    @State var didTapped: Bool = false
    @State var isDone: Bool = false
    @Binding var showEditMode: Bool
    
    var actionTapRow: (SupermarketItem) -> Void
    
    var body: some View {
        VStack {
            HStack {
                
                if showEditMode {
                    Image((showEditMode && didTapped) ? "ic_check" : "ic_check_empty")
                        .resizable()
                        .frame(width: 21, height: 20)
                        .padding(.leading, 4)
                        .padding(.trailing, 4)
                        .animation(.spring())
                }
                
                VStack {
                    HStack {
                        if self.supermarketItem.avatarJPEGData != nil {
                            Image(uiImage: UIImage(data:self.supermarketItem.avatarJPEGData!)!)
                                .resizable()
                                .frame(width: 56, height: 56)
                                
                        }

                        VStack(alignment: .leading) {
                            Text(supermarketItem.name)
                                .foregroundColor(.label)
                                .font(.body)
                                .strikethrough(isDone)
                            HStack {
                                HStack {
                                    Text("Qnt:")
                                        .foregroundColor(.label)
                                        .font(.body)
                                        .strikethrough(isDone)
                                    Text(supermarketItem.amount)
                                        .foregroundColor(.label)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .strikethrough(isDone)
                                }
                                Spacer()
                                if !supermarketItem.price.isEmpty {
                                    Text(supermarketItem.price)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("buttonAction"))
                                        .strikethrough(isDone)
                                }
                            }
                            .padding(.top, 8)
                        }
                        
                    }
                    
                    Rectangle()
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                }
            }
        

        }
        .foregroundColor(.tertiarySystemBackground).opacity(isDone ? 0.4 : 1)
        .frame(height: 76)
        .onTapGesture {
            self.didTapped.toggle()
            self.actionTapRow(self.supermarketItem)
            if self.didTapped && !self.showEditMode {
                self.isDone.toggle()
            }
        }
    }
    
}

struct SupermarketRow_Previews: PreviewProvider {
    static var previews: some View {
        SupermarketRow(supermarketItem: SupermarketItem(), cartID: UUID(), showEditMode: .constant(true), actionTapRow: {_ in })
    }
}
