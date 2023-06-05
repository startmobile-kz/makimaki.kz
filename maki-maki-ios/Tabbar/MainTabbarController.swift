//
//  MainTabbarController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 03.06.2023.
//

import UIKit

class MainTabbarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbars()
    }

    // MARK: - Setup

    private func setupTabbars() {
        // Create Tab one
        let main = UINavigationController(rootViewController: MainViewController())
        let mainItem = UITabBarItem(title: "Main",
                                    image: AppImage.house.systemImage,
                                    selectedImage: AppImage.house_fill.systemImage)
        main.tabBarItem = mainItem
        
        let orders = UINavigationController(rootViewController: OrdersViewController())
//        orders.navigationBar.prefersLargeTitles = true

        let ordersItem = UITabBarItem(title: "Orders",
                                      image: AppImage.house.systemImage,
                                      selectedImage: AppImage.house_fill.systemImage)
        orders.tabBarItem = ordersItem
        
        let account = UINavigationController(rootViewController: AccountCardsViewController())
//        account.navigationBar.prefersLargeTitles = true
        let accountItem = UITabBarItem(title: "Account",
                                      image: AppImage.house.systemImage,
                                      selectedImage: AppImage.house_fill.systemImage)
        account.tabBarItem = accountItem
        
        self.viewControllers = [main, orders, account]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
