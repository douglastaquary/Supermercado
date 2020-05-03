//
//  PopoverView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 02/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct PopoverView: View {
    
    @Binding var showPopover: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.edgesIgnoringSafeArea([.all]).opacity(self.showPopover ? 0.4 : 1)
            VStack(alignment: .leading, spacing: 18) {
                Button(action: {
                    
                }) {
                    HStack(spacing: 15) {
                        Text("Editar")
                            .foregroundColor(Color("buttonAction"))
                    }
                }
                
                Divider()
                
                Button(action: {
                    
                }) {
                    HStack(spacing: 15) {
                        Text("Remover")
                            .foregroundColor(Color("buttonAction"))
                    }
                }
            }
            .frame(width: 150)
            .padding()
            .cornerRadius(4)
            .foregroundColor(.systemBackground)
            //.padding(.top, 24)
            .background(Color.white)
            //.clipShape(ArrowShape())
        }
        
        
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = rect.width/2
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - 20))
            
            path.addLine(to: CGPoint(x: center - 15, y: rect.height - 20))
            path.addLine(to: CGPoint(x: center, y: rect.height))
            path.addLine(to: CGPoint(x: center + 15, y: rect.height - 20))
            
            path.addLine(to: CGPoint(x: 0, y: rect.height - 20))
        }
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView(showPopover: .constant(true))
    }
}
