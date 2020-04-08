//
//  SceneDelegate.swift
//  Supermercado
//
//  Created by Douglas Taquary on 29/03/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let supermarketsView = SupermarketsView()
//                    .environmentObject(appDelegate.supermarketService)
//                    .accentColor(.green)
            window.rootViewController = UIHostingController(rootView: HomeView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.supermarketService.sync()
    }


}

