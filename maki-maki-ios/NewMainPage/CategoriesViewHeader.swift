//
//  CategoriesViewHeader.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 30.06.2023.
//

import UIKit
import SnapKit

final class СategoriesHeaderView: UICollectionReusableView {
    
    // MARK: - State
    
    static let reuseID = String(describing: СategoriesHeaderView.self)
    
    // MARK: - UI
    
    private lazy var categoryView: CategoryMenuView = {
        let view = CategoryMenuView(type: .collectionHeader)
        return view
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
    
    // MARK: - SetupViews
    
    private func setupViews() {
        addSubview(categoryView)
        isSkeletonable = true
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

