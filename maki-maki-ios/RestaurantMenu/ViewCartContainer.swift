//
//  ViewCartContainer.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import Foundation
import SnapKit

final class ViewCartConatiner : UIView {
    
    // MARK: - UI
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.border.uiColor
        return view
    }()
    
    private lazy var viewCartView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.accent.uiColor
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var countButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.heading.uiColor
        button.setTitle("3", for: .normal)
        button.titleLabel?.font = AppFont.reqular.s14()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var viewCartLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        label.text = "VIEW CART"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        label.text = "$25.98"
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
        viewCartView.addSubviews([countButton, viewCartLabel, priceLabel])
        addSubviews([separatorView, viewCartView])
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        viewCartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
        
        countButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(25)
        }
        
        viewCartLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
