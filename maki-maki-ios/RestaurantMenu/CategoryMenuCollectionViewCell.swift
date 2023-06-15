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
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.reqular.s14()
        return label
    }()
    
    // MARK: - State
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = self.isSelected ? AppColor.accent.uiColor
            : AppColor.background.uiColor
            categoryLabel.textColor = self.isSelected ? AppColor.heading.uiColor : AppColor.paragraph.uiColor
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
        contentView.layer.cornerRadius = 14
        contentView.addSubview(categoryLabel)
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(contentView.snp.width)
        }
    }
}
