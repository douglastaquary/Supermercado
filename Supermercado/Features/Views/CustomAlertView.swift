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
    var bodyLabel: String
    var callToActionButton: String
    
    @Binding var showingModal: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color.secondary.edgesIgnoringSafeArea(.all)
            VStack {
                Text(titleLabel)
                    .font(.headline)
                    .bold()
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .frame(height: 38)
                Text(bodyLabel)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .padding(.bottom, 20)
                    .padding(.top, 8)
                    .padding(.horizontal, 20)
                Button(action: { self.showingModal = false }) {
                        Text(callToActionButton)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color("buttonAction"))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .frame(width: 280, height: 220)
            .background(colorScheme == .light ?  Color.white : Color.black)
            .cornerRadius(16)
            .shadow(radius: 20)
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        let body = "Unable to complete your request. Please check your internet connection."
        let buttonText = "Ok"
        return CustomAlertView(bodyLabel: body, callToActionButton: buttonText, showingModal: .constant(true))
    }
}
