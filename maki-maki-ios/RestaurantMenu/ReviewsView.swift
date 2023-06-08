//
//  ReviewsView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 08.06.2023.
//

import UIKit
import SnapKit

class ReviewsView: UIView {
    
    //MARK: - UI
    lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
