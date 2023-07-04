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
        let mainViewController = SecondMainViewController()
        let searchViewController = SearchV1ViewController()
        let ordersViewController = OrdersViewController()
        let profileViewController = AccountListViewController()
        
        mainViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: AppImage.home.uiImage,
            selectedImage: AppImage.home_selected.uiImage
        )
        searchViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: AppImage.search.uiImage,
            selectedImage: AppImage.search_selected.uiImage
        )
        ordersViewController.tabBarItem = UITabBarItem(
            title: "Orders",
            image: AppImage.shopping_bag.uiImage,
            selectedImage: AppImage.shopping_bag_selected.uiImage
        )
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: AppImage.user.uiImage,
            selectedImage: AppImage.user_selected.uiImage
        )
        
        self.viewControllers = [
            mainViewController,
            searchViewController,
            ordersViewController,
            profileViewController
        ]
    }
}
