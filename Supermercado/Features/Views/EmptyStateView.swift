////
////  EmptyStateView.swift
////  Supermercado
////
////  Created by Douglas Taquary on 08/04/20.
////  Copyright © 2020 Douglas Taquary. All rights reserved.
////
//
import SwiftUI


struct EmptyStateView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Image("ic_empty_list")
                    .resizable()
                    .frame(width: 48, height: 62)
                    .padding(32)
                    .padding(.top, 56)
                Text("Ainda não existem\nlistas registradas")
                    .fontWeight(.bold)
                    .lineLimit(nil)
                    .foregroundColor(.label)
                    .font(Font.system(size: 18))
                    .multilineTextAlignment(.center)
                Text("Crie suas listas e tenha essa facilidade à sua disposição. Deseja começar?")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(16)
                Spacer()
                Text("Suas listas cadastradas podem ser usadas para personalizar suas experiências e melhorar o aplicativo.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(8)
                    
            }
            .padding()
        }
        
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()//.environment(\.colorScheme, .dark)
    }
}
