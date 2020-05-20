//
//  ActivityIndicatorView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 05/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI


import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).opacity(0.8).edgesIgnoringSafeArea(.all)
            ActivityIndicator(style: .medium)
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
