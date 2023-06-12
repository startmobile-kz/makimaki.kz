//
//  HeaderCollectionView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 12.06.2023.
//

import UIKit
import SnapKit

class HeaderCollectionView: UIView {
    
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
        backgroundColor = AppColor.accent.uiColor
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}