//
//  ContainerView.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 05.06.2023.
//

import UIKit
import SnapKit
import ProgressHUD

class ContainerView: UIView {

    // MARK: - UI
    
    private lazy var dividerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "divider")
        return imageView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = AppFont.medium.s20()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = AppFont.semibold.s24()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.setTitle("CHECKOUT", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        button.addTarget(self, action: #selector(checkoutButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var checkoutPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    
    private func setupViews() {
        self.backgroundColor = .white
        
        [dividerImage, totalLabel, priceLabel, checkoutButton, checkoutPriceLabel].forEach {
            addSubview($0)
        }
    }
    
    // MARK: - Setup Constrains
    
    private func setupConstrains() {
        dividerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(53)
        }
        
        checkoutPriceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(checkoutButton.snp.trailing).offset(-16)
            make.centerY.equalTo(checkoutButton)
        }
    }

    // MARK: - Actions

    @objc
    private func checkoutButtonDidPress() {
        ProgressHUD.show("Loading..", interaction: false)
    }
}
