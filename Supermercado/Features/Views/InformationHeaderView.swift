//
//  InformationHeaderView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct InformationHeaderView: View {
    
    @State var titleHeader: String = ""
    @State var countItems: Int = 0
    @State var imageName: String = "Outros" 
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.systemBackground.edgesIgnoringSafeArea([.all])
            if countItems == 0 {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight:148)
                    .foregroundColor(.tertiarySystemBackground)
                    .shadow(radius: 0, x: 0, y: 0).opacity(0.4)
            } else {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 116)
                    .foregroundColor(.tertiarySystemBackground)
                    .shadow(radius: 0, x: 0, y: 0).opacity(0.4)
            }

            VStack(alignment: .leading) {
                HStack {
                    Image(imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color("buttonAction"))
                        .frame(width: 40, height: 40, alignment: .center)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(titleHeader)
                            .font(.body)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.label)
                        Text("\(countItems) itens adicionados")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(12)
                }
                Rectangle()
                    .cornerRadius(4)
                    .foregroundColor(Color("buttonAction"))
                    .frame(maxWidth: .infinity, maxHeight: 1)
                
                if countItems == 0 {
                    Text("Para adicionar produtos em sua lista clique no botão Adicionar item.")
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(Color("secondaryText"))
                        .multilineTextAlignment(.center)
                        .padding(8)
                }

            }
                
            .frame(maxWidth: .infinity, maxHeight: countItems == 0 ? 148 : 106)

        }

    }
}

struct InformationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        InformationHeaderView().environment(\.colorScheme, .dark)
    }
}
