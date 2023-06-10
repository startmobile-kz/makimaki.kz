//
//  CategoryCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 01.06.2023.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: CategoryCollectionViewCell.self)
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                categoryButton.backgroundColor = AppColor.accent.uiColor
            } else {
                categoryButton.backgroundColor = AppColor.background.uiColor
            }
        }
    }
    
    // MARK: - UI
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "burger"), for: .normal)
        button.backgroundColor = AppColor.background.uiColor
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.4
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Burgers"
        label.font = AppFont.reqular.s12()
        label.textColor = AppColor.paragraph.uiColor
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        let subviews = [categoryButton, categoryNameLabel]
        subviews.forEach({contentView.addSubview($0)})
    }
    
    // MARK: - SetupConstraints
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
    
    // MARK: - Button actions
    @objc func categoryButtonTapped() {
        isSelected.toggle()
    }
}
