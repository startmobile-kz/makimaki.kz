//
//  CategoryCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 01.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: CategoryCollectionViewCell.self)
    
    // MARK: - UI
    
    private lazy var categoryCellView: UIView = {
        let button = UIView()
        button.backgroundColor = AppColor.background.uiColor
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.4
        return button
    }()
    
    private lazy var categoryImage: UIImageView = {
        
        let image = UIImageView()
        image.image = AppImage.burger.uiImage
        image.isSkeletonable = true
        image.showSkeleton() 
        return image
    }()
    
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Burgers"
        label.font = AppFont.reqular.s12()
        label.textColor = AppColor.paragraph.uiColor
        label.numberOfLines = 0
        label.textAlignment = .center
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
        isSkeletonable = true
        categoryCellView.addSubview(categoryImage)
        let subviews = [categoryCellView, categoryNameLabel]
        subviews.forEach({contentView.addSubview($0)})
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        categoryCellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)
        }
        categoryImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            
        }
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryCellView.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
            make.width.equalTo(65)
        }
    }
    
    // MARK: Did set function
    
    func set(value: Bool) {
        if value {
            categoryCellView.backgroundColor = AppColor.accent.uiColor
        } else {
            categoryCellView.backgroundColor = AppColor.background.uiColor
        }
    }
    
    // MARK: - Public
    
    public func setupData(category: Category) {
        categoryNameLabel.text = category.name
    }
}
