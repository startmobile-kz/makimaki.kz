//
//  TabBarItem.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 06.06.2023.
//

import UIKit

class TabBarItem: UIView {
    
    // MARK: - UI
    private lazy var tabImageView: UIImageView = {
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private lazy var dotImageView: UIImageView = {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
