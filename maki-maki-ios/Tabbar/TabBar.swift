//
//  TabBar.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 06.06.2023.
//

import UIKit
import SnapKit

protocol TabBarDelegate: AnyObject {
    func tabBar(_ tabBar: TabBar, didSelectTabAt index: Int)
}

final class TabBar: UIView {
    var viewControllers = [UIViewController]() {
        didSet {
            
        }
    }
    
    // MARK: - UI
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.border.uiColor
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        return stackView
    }()
    
    // MARK: Properties
    private var selectedIndex = 0
    private var previousSelectedIndex = 0
    weak var tabBarDelegate: TabBarDelegate?
    var tabWidth: CGFloat {
        return (UIScreen.main.bounds.width - 74) / CGFloat(viewControllers.count)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        backgroundColor = AppColor.background.uiColor
        addSubviews([separatorView, stackView])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        
//        stackView.frame = self.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(-0.5)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.height.equalTo(0.5)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(21)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.height.equalTo(32)
        }
    }
    
    // MARK: - SetupBars
    private func setupBars() {
        for vc in viewControllers {
            let barView = TabBarItem(tabBarItem: vc.tabBarItem)
            barView.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(barView)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchArea = touches.first?.location(in: self).x else {
            return
        }
        let index = Int(floor(touchArea / tabWidth))
        didSelectTab(index: index)
    }
    
    private func didSelectTab(index: Int) {
        if index + 1 == selectedIndex {return}
        changeTab(index: index)
 
        previousSelectedIndex = selectedIndex
        selectedIndex = index + 1
        
        tabBarDelegate?.tabBar(self, didSelectTabAt: index)
    }
    
    private func changeTab(index: Int) {
        self.stackView.arrangedSubviews.enumerated().forEach {
            guard let tabView = $1 as? TabBarItem else { return }
            ($0 == index ? tabView.selectTab : tabView.deselectTab)()
        }
    }
}

