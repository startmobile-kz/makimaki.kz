//
//  PageHeaderView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 12.06.2023.
//

import UIKit
import SnapKit

class PageHeaderView: UICollectionReusableView {
    
    static let reuseID = String(describing: PageHeaderView.self)
    
    // MARK: - UI
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    private lazy var viewWithCollection: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.accent.uiColor
        return view
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
        addSubviews([topView, viewWithCollection])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(-14)
            make.height.equalTo(254)
        }
        
        viewWithCollection.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalTo(-14)
            make.height.equalTo(40)
        }
    }
}
