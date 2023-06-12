//
//  CategoryMenuCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class CategoryMenuCollectionViewCell: UICollectionViewCell {
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.reqular.s14()
        return label
    }()
    
//    func following (sender: AnyObject){
//        if categoryButton.tag == sender.tag {
//            categoryButton.setTitle("Most Popular", for: .normal)
//        }
//    }
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = self.isSelected ? AppColor.accent.uiColor
            : AppColor.background.uiColor
            categoryLabel.textColor = self.isSelected ? AppColor.heading.uiColor : AppColor.paragraph.uiColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 14
        contentView.addSubview(categoryLabel)
    }
    
    private func setConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(contentView.snp.width)
        }
    }
}
