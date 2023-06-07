//
//  TabBarController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 06.06.2023.
//

import UIKit
import SnapKit

protocol TabBarControllerDelegate: NSObjectProtocol {
    func tabBarController(_ tabBarController: TabBarController, didSelect viewController: UIViewController)
}

class TabBarController: UIViewController, TabBarDelegate {
    
    // MARK: - Properties
    weak var delegate: TabBarControllerDelegate?
    
    var selectedIndex = 0
//    var previousSelectedIndex = 0
    
    var viewControllers = [UIViewController]() {
        didSet {
            tabBar.viewControllers = viewControllers
        }
    }
    
    // MARK: - UI
    private lazy var tabBar: TabBar = {
        let tabBar = TabBar()
        tabBar.tabBarDelegate = self
        return tabBar
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.background.uiColor
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.addSubview(containerView)
        view.addSubview(tabBar)
        view.bringSubviewToFront(tabBar)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {

        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(tabBar.snp.top)
        }
        
        tabBar.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(83)
        }
    }
    
    func tabBar(_ tabBar: TabBar, didSelectTabAt index: Int) {
        print("index", index)
        let previousVC = viewControllers[index]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
//        previousSelectedIndex = selectedIndex
        
        let vc = viewControllers[index]
        delegate?.tabBarController(self, didSelect: vc)
        addChild(vc)
        selectedIndex = index + 1
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
}
