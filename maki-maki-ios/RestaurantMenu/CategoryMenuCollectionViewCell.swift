//
//  CategoryMenuCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class CategoryMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var categoryView: CategoryMenuView = {
        let view = CategoryMenuView()
        return view
    }()
    
    // MARK: - State
    
    override var isSelected: Bool {
        didSet {
            categoryView.backgroundColor = self.isSelected ? AppColor.accent.uiColor
            : AppColor.background.uiColor
        }
    }
    
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
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        categoryView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(contentView.snp.width)
        }
    }
}
