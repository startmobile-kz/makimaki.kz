//
//  SectionsHeaderView.swift
//  maki-maki-ios
//
//  Created by Tami on 13.06.2023.
//

import UIKit
import SnapKit

final class ProductSectionHeaderView: UICollectionReusableView {
    
    // MARK: - State
    
    static let reuseId = String(describing: ProductSectionHeaderView.self)
    
    // MARK: - UI
    
    private lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.semibold.s20()
        label.sizeToFit()
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
    
    func setSectionHeaderTitle(title: String) {
        sectionLabel.text = title
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        addSubview(sectionLabel)
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        sectionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
