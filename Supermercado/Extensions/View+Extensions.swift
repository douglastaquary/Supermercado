//
//  View+Extensions.swift
//  Supermercado
//
//  Created by Douglas Taquary on 29/03/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

extension View {

    func popover(isShowing: Binding<Bool>) -> some View {
        PopoverView(
            isShowing: isShowing,
              presenting: { self }
        )
    }

}

