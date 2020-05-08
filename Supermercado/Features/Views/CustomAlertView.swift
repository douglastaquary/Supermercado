//
//  CustomAlertView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 02/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

struct CustomAlertView: View {
    
    var titleLabel: String = "Bad Stuff Happened"
    var bodyLabel: String = ""
    @State var cartName: String = "connection"
    var callToActionLeftButton: String = "Não"
    var callToActionRightButton: String = "Sim"
    var leftAction: () -> Void
    var rightAction: () -> Void
    
    
    @Binding var showingModal: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color.secondary.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text(titleLabel)
                    .font(.body)
                    .foregroundColor(.label)
                    .bold()
                    .frame(height: 24)
                
                HighlightedText(
                    bodyLabel,
                    matching: self.cartName
                )
                .font(.body)
                .foregroundColor(.label)
                .multilineTextAlignment(.leading)
                .lineLimit(4)
                .padding(12)

                Spacer()
                HStack(spacing: 16) {
                    Button(action: {
                        self.showingModal = false
                        self.leftAction()
                    }) {
                            Text(callToActionLeftButton)
                                .foregroundColor(.label)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(Color.systemBackground)
                                .border(Color.secondaryLabel, width: 1)
                                .cornerRadius(4)
                    }
                    Button(action: {
                        self.showingModal = false
                        self.rightAction()
                    }) {
                            Text(callToActionRightButton)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(Color("buttonAction"))
                                .cornerRadius(4)
                    }
                }
                .padding()
                
            }
            .frame(width: 280, height: 220)
            .background(colorScheme == .light ?  Color.white : Color.black)
            .cornerRadius(4)
            .shadow(radius: 20)
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        let body = "Unable to complete your request. Please check your internet connection."
        return CustomAlertView(bodyLabel: body,leftAction: { }, rightAction: {}, showingModal: .constant(true))
    }
}


struct HighlightedText: View {
    let text: String
    let matching: String

    init(_ text: String, matching: String) {
        self.text = text
        self.matching = matching
    }

    var body: some View {
        let tagged = text.replacingOccurrences(of: self.matching, with: "<SPLIT>>\(self.matching)<SPLIT>")
        let split = tagged.components(separatedBy: "<SPLIT>")
        return split.reduce(Text("")) { (a, b) -> Text in
            guard !b.hasPrefix(">") else {
                return a + Text(b.dropFirst()).foregroundColor(.label).fontWeight(.bold)
            }
            return a + Text(b)
        }
    }
}
