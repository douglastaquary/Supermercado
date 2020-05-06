//
//  PopoverView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 02/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

public enum PopoverSelected {
    case edit
    case remove
}

struct PopoverView<Presenting>: View where Presenting: View {
    @Environment(\.colorScheme) var colorScheme
    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    @State var action: () -> Void
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting

    var body: some View {

        GeometryReader { geometry in

            ZStack(alignment: .topTrailing) {

                self.presenting()
                    .blur(radius: self.isShowing ? 5 : 0)
                    .onTapGesture {
                        self.isShowing = false
                    }
                
                VStack {
                    VStack(alignment: .leading, spacing: 18) {
                        Button(action: {
                            self.action()
                            self.isShowing = false
                        }) {
                            HStack(spacing: 15) {
                                Text("Editar")
                                    .frame(height: 24)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("buttonAction"))
                            }
                        }
                        Divider()
                        Button(action: {
                           self.isShowing = false
                        }) {
                            HStack(spacing: 15) {
                                Text("Cancelar")
                                    .frame(height: 24)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("buttonAction"))
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.systemBackground)
                    .background(self.colorScheme == .light ? .white : Color.tertiarySystemBackground)
                    .cornerRadius(4)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 4)
                    .transition(.slide)
                    .opacity(self.isShowing ? 1 : 0)
                    
                }
                .shadow(color: Color("DividerColor"), radius: 8, x: 0, y: 5)
                .padding(.top, -36)
                .padding(.trailing, 16)

                
            }
            
        }

    }

}
