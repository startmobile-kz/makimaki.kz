//
//  Main2TabBarController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 06.06.2023.
//

import UIKit
import SnapKit

class Main2TabBarController: TabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBars()
    }
    
    private func setupTabBars() {
        let mainVC = MainViewController()
        let searchVC = EditProfileViewController()
        let ordersVC = OrdersViewController()
        let profileVC = WelcomePageVerOneViewController()
        
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: AppImage.home.uiImage, selectedImage: nil)
        searchVC.tabBarItem = UITabBarItem(
            title: "Search", image: AppImage.search.uiImage, selectedImage: nil)
        ordersVC.tabBarItem = UITabBarItem(
            title: "Orders", image: AppImage.shopping_bag.uiImage, selectedImage: nil)
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile", image: AppImage.user.uiImage, selectedImage: nil)
        
        self.viewControllers = [mainVC, searchVC, ordersVC, profileVC]
    }
}
