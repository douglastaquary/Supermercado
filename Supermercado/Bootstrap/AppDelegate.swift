//
//  AppDelegate.swift
//  Supermercado
//
//  Created by Douglas Taquary on 29/03/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var supermarketService: SupermarketService = {
        SupermarketService()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let preSyncVersion = supermarketService.storeCoordinator.currentVersion
        supermarketService.sync { _ in
            let result: UIBackgroundFetchResult = self.supermarketService.storeCoordinator.currentVersion == preSyncVersion ? .noData : .newData
            completionHandler(result)
        }
    }

}


