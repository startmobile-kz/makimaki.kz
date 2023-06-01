//
//  CategoryCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 01.06.2023.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CategoryCell"
    
    // MARK: -UI
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Category1"), for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Burgers"
        label.font = AppFont.reqular.s12()
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Setup Views
    private func setupViews() {
        let subviews = [categoryButton, categoryNameLabel]
        subviews.forEach( { contentView.addSubview($0) } )
    }
    
    // MARK: -Setup Constraints
    private func setupConstraints() {
        categoryButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(70)
        }
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(5)
            make.leading.equalTo(categoryButton.snp.leading)
            make.centerX.equalTo(contentView)
        }
    }
}
