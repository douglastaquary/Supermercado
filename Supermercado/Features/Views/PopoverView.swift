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
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting

    var body: some View {

        GeometryReader { geometry in

            ZStack(alignment: .topTrailing) {

                self.presenting()
                    .foregroundColor(.black)
                    .blur(radius: self.isShowing ? 5 : 0)
                    .onTapGesture {
                        self.isShowing = false
                    }
                
                VStack(alignment: .leading, spacing: 18) {
                    Button(action: {
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
                            Text("Remover")
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
                .background(self.colorScheme == .light ? Color.secondarySystemBackground : Color.tertiarySystemBackground)
                .cornerRadius(4)
                .frame(width: geometry.size.width / 2, height: geometry.size.height / 4)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
        .padding()

    }

}

//struct PopoverView: View {
//    @State var editMode: PopoverSelected = .remove
//
//    @Binding var showPopover: Bool
//    @Environment(\.colorScheme) var colorScheme
//
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            Color.label.edgesIgnoringSafeArea([.all]).opacity(self.showPopover ? 0.4 : 0)
//            if self.showPopover {
//                renderPopover()
//            }
//        }
//        .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
//    }
//
//
//    private func renderPopover() -> some View {
//        return VStack {
//            VStack(alignment: .leading, spacing: 18) {
//                Button(action: {
//                    self.showPopover = false
//                }) {
//                    HStack(spacing: 15) {
//                        Text("Editar")
//                            .frame(height: 24)
//                            .foregroundColor(Color("buttonAction"))
//                    }
//                }
//                Divider()
//                Button(action: {
//                   self.showPopover = false
//                }) {
//                    HStack(spacing: 15) {
//                        Text("Remover")
//                            .frame(height: 24)
//                            .foregroundColor(Color("buttonAction"))
//                    }
//                }
//            }
//            .frame(width: 150)
//            .padding()
//            .foregroundColor(.systemBackground)
//            .background(colorScheme == .light ? Color.white : Color.black)
//            .cornerRadius(4)
//        }
//        .padding(.top, 12)
//        .padding()
//    }
//}

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

//struct PopoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopoverView<<#Presenting: View#>>(showPopover: .constant(true))
//    }
//}
