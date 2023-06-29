//
//  SceneDelegate.swift
//  maki-maki-ios
//
//  Created by Shyngys on 16.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.overrideUserInterfaceStyle = .light

            let isAuthoried = false
            if isAuthoried {
                window.rootViewController = Main2TabBarController()
            } else {
                window.rootViewController =
                    UINavigationController(rootViewController: Main2TabBarController())
            }
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
