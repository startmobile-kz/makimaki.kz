//
//  AppDelegate.swift
//  maki-maki-ios
//
//  Created by Shyngys on 16.05.2023.
//

import UIKit
import FirebaseCore
import IQKeyboardManager
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // swiftlint:disable line_length
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        
        YandexMapsConfiguration.configure()
        
        return true
    }
    // swiftlint:enable line_length

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
    }
}
