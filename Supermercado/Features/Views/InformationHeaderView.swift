//
//  InformationHeaderView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct InformationHeaderView: View {
    
    @State var showEmptyDescription: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                //.cornerRadius(4)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: showEmptyDescription ? 148 : 116)
            VStack(alignment: .leading) {
                HStack {
                    Image("churras")
                        .resizable()
                        .frame(width: 48, height: 48, alignment: .center)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Churrasco do beto")
                            .font(.body)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                        Text("0 item adicionados")
                            .font(.caption)
                            .foregroundColor(Color("secondaryText"))
                            .multilineTextAlignment(.center)
                    }
                    .padding(12)
                }
                Rectangle()
                    .cornerRadius(4)
                    .foregroundColor(Color("buttonAction"))
                    .frame(maxWidth: .infinity, maxHeight: 1)
                
                if self.showEmptyDescription {
                    Text("Para adicionar produtos em sua lista clique no botão adicionar item.")
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(Color("secondaryText"))
                        .multilineTextAlignment(.center)
                        .padding(8)
                }

            }
            .frame(maxWidth: .infinity, maxHeight: showEmptyDescription ? 148 : 106)
            .padding(.leading, 16)
            .padding(.trailing, 16)

        }
    }
}

struct InformationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        InformationHeaderView()
    }
}
