//
//  CategoryMenuView.swift
//  maki-maki-ios
//
//  Created by Tami on 15.06.2023.
//

import UIKit
import SnapKit

final class CategoryMenuView: UIView {
    
    // MARK: - UI
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.reqular.s14()
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - SetupViews
    
    private func setupViews() {
        backgroundColor = AppColor.accent.uiColor
        layer.cornerRadius = 14
        
        addSubview(categoryLabel)
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        
        categoryLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
    }
}
