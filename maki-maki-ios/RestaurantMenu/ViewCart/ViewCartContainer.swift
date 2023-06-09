//
//  ViewCartContainer.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class ViewCartContainer : UIView {
    
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
        view.isSkeletonable = true
        view.skeletonCornerRadius = 14
        return view
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppColor.heading.uiColor
        label.textColor = AppColor.background.uiColor
        label.font = AppFont.reqular.s14()
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.isHidden = true
        return label
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
        backgroundColor = AppColor.background.uiColor
        viewCartView.addSubviews([countLabel, viewCartLabel, priceLabel])
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
        
        countLabel.snp.makeConstraints { make in
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
    
    // MARK: - Actions
    
    public func setupData(products: [RestaurantProduct]) {
        let totalPrice = products.reduce(0) { partialResult, product in
            return partialResult + (product.count * product.price)
        }
        countLabel.isHidden = false
        countLabel.text = "\(products.count)"
        priceLabel.text =  "\(totalPrice) ₸"
    }
}
