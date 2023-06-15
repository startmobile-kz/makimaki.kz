//
//  RestaurantHeaderView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.06.2023.
//

import UIKit
import SnapKit

class RestaurantHeaderView: UICollectionReusableView {
    
    static let reuseID = String(describing: RestaurantHeaderView.self)
    
    // MARK: - UI
    
    // MARK: - Lifecycle
    
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
        backgroundColor = .cyan
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        
    }
}
