//
//  TabBarItem.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 06.06.2023.
//

import UIKit
import SnapKit

class TabBarItem: UIView {
    
    // MARK: - UI
    private lazy var tabImageView: UIImageView = {
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private lazy var ellipseImageView: UIImageView = {
        let imageView = UIImageView(image: AppImage.ellipse.uiImage)
        
        return imageView
    }()
    
    // MARK: - Properties
    private let image: UIImage
    
    // MARK: - Lifecycle
    init(tabBarItem item: UITabBarItem) {
        guard let tabImage = item.image else {
            fatalError("You should set image to all view controllers")
        }
        self.image = tabImage
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        addSubviews([tabImageView, ellipseImageView])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        tabImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(22)
            make.height.equalTo(20)
        }
        
        ellipseImageView.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(4)
            make.bottom.equalTo(tabImageView.snp.bottom).offset(6)
            make.centerX.equalTo(self.snp.center)
        }
    }
    
    func selectTab() {
        ellipseImageView.alpha = 1
        tabImageView.image = tabImageView.image?.withRenderingMode(.alwaysTemplate)
        tabImageView.tintColor = AppColor.accent.uiColor
     }
     
     func deselectTab() {
         ellipseImageView.alpha = 0
         tabImageView.image = tabImageView.image?.withRenderingMode(.alwaysTemplate)
         tabImageView.tintColor = AppColor.paragraph.uiColor
     }
}
