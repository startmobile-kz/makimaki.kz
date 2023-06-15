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
    
    private lazy var viewCartView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.accent.uiColor
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var countButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.heading.uiColor
        button.setTitleColor(AppColor.background.uiColor, for: .normal)
        button.titleLabel?.text = "3"
        button.titleLabel?.font = AppFont.reqular.s14()
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
        addSubview(viewCartView)
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        
    }
}
