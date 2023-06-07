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
    private var selectedIndex = 0
    private var previousSelectedIndex = 0
    weak var tabBarDelegate: TabBarDelegate?
    private var spacing = (UIScreen.main.bounds.width - 4 * 20) / 4
    
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
        
        stackView.frame = self.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        stackView.arrangedSubviews.forEach { $0.layoutMargins = UIEdgeInsets.zero }
        stackView.isLayoutMarginsRelativeArrangement = true
        
        let size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        print(size, "size")
        separatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-1)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(spacing / 2)
        }
    }
    
    // MARK: - SetupBars
    private func setupBars() {
        for index in stride(from: 0, to: viewControllers.count, by: 1) {
            let barView = TabBarItem(tabBarItem: viewControllers[index].tabBarItem, index: index)
            barView.tabItemDelegate = self
//            barView.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(barView)
        }
    }

    private func didSelectTab(index: Int) {
        if index + 1 == selectedIndex {
            return
        }
        changeTab(index: index)
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

extension TabBar: TabBarItemDelegate {
    func itemPressed(index: Int) {
        print("PREESSSEEED")
        didSelectTab(index: index)
    }
}
