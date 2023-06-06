//
//  Main2TabBarController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 06.06.2023.
//

import UIKit
import SnapKit

class Main2TabBarController: TabBarController, TabBarControllerDelegate {
    func tabBarController(_ tabBarController: TabBarController, didSelect viewController: UIViewController) {
        print("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.delegate = self
        let mainVC = MainViewController()
        let searchVC = EditProfileViewController()
        let ordersVC = OrdersViewController()
        let profileVC = WelcomePageVerOneViewController()
        
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: nil)
        searchVC.tabBarItem = UITabBarItem(
            title: "Search", image: UIImage(named: "search"), selectedImage: nil)
        ordersVC.tabBarItem = UITabBarItem(
            title: "Orders", image: UIImage(named: "shopping_bag"), selectedImage: nil)
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile", image: UIImage(named: "user"), selectedImage: nil)
        
        self.viewControllers = [mainVC, searchVC, ordersVC, profileVC]
    }
}
