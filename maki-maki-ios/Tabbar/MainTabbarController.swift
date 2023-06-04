//
//  MainTabbarController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 03.06.2023.
//

import UIKit

//UITabBarControllerDelegate
class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbars()
    }
    
    private func setupTabbars() {
        // Create Tab one
        let main = MainViewController()
        let mainItem = UITabBarItem(title: "Main",
                                    image: AppImage.house.systemImage,
                                    selectedImage: AppImage.house_fill.systemImage)
        main.tabBarItem = mainItem
        
        
        let orders = OrdersViewController()
        let ordersItem = UITabBarItem(title: "Orders",
                                      image: AppImage.house.systemImage,
                                      selectedImage: AppImage.house_fill.systemImage)
        orders.tabBarItem = ordersItem
        
        let account = AccountCardsViewController()
        let accountItem = UITabBarItem(title: "Account",
                                      image: AppImage.house.systemImage,
                                      selectedImage: AppImage.house_fill.systemImage)
        account.tabBarItem = accountItem
        
        
        self.viewControllers = [main, orders, account]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
