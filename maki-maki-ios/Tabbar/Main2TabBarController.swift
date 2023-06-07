//
//  Main2TabBarController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 06.06.2023.
//

import UIKit
import SnapKit

final class Main2TabBarController: TabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBars()
    }
    
    private func setupTabBars() {
        let mainViewController = MainViewController()
        let searchViewController = EditProfileViewController()
        let ordersViewController = OrdersViewController()
        let profileViewController = WelcomePageVerOneViewController()
        
        mainViewController.tabBarItem = UITabBarItem(title: "Home", image: AppImage.home.uiImage, selectedImage: nil)
        searchViewController.tabBarItem = UITabBarItem(
            title: "Search", image: AppImage.search.uiImage, selectedImage: nil)
        ordersViewController.tabBarItem = UITabBarItem(
            title: "Orders", image: AppImage.shopping_bag.uiImage, selectedImage: nil)
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile", image: AppImage.user.uiImage, selectedImage: nil)
        
        self.viewControllers = [mainViewController, searchViewController, ordersViewController, profileViewController]
    }
}
