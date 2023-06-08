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
    
    // MARK: Properties
    private var selectedIndex = -1
    
    weak var tabBarDelegate: TabBarDelegate?
    
    private var spacing = TabBarSettings.spacingBetweenItems
    
    var viewControllers = [UIViewController]() {
        didSet {
            setupBars()
            guard !viewControllers.isEmpty else {
                return
            }
            setupConstraints()
            layoutIfNeeded()
            didSelectTab(index: 0)
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
        stackView.spacing = spacing
        return stackView
    }()
    
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
        separatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-0.5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(spacing / 2)
        }
    }
    
    // MARK: - SetupBars
    private func setupBars() {
        for index in stride(from: 0, to: viewControllers.count, by: 1) {
            let barView = TabBarItem(tabBarItem: viewControllers[index].tabBarItem, index: index)
            barView.tabItemDelegate = self
            self.stackView.addArrangedSubview(barView)
        }
    }

    private func didSelectTab(index: Int) {
        if index == selectedIndex {
            return
        }
        changeTab(index: index)
        selectedIndex = index
        tabBarDelegate?.tabBar(self, didSelectTabAt: index)
    }
    
    private func changeTab(index: Int) {
        self.stackView.arrangedSubviews.enumerated().forEach {
            guard let tabView = $1 as? TabBarItem else { return }
            ($0 == index ? tabView.selectTab : tabView.deselectTab)()
        }
    }
}

// MARK: - TabBarItem delegate
extension TabBar: TabBarItemDelegate {
    func itemPressed(index: Int) {
        didSelectTab(index: index)
    }
}
