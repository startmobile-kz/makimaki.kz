//
//  DishCategoryCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class DishCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - State
    
    static let reuseID = String(describing: DishCategoryCollectionViewCell.self)
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = self.isSelected ? AppColor.accent.uiColor
            : AppColor.background.uiColor
            categoryLabel.textColor = self.isSelected ? AppColor.heading.uiColor :
            AppColor.paragraph.uiColor
        }
    }
    
    // MARK: - UI
    
    public lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        return label
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
        contentView.layer.cornerRadius = 14
        addSubview(categoryLabel)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
