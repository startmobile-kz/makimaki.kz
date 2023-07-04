//
//  ContainerView.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 05.06.2023.
//

import UIKit
import SnapKit

protocol CheckoutButtonDelegate: AnyObject {
    func checkoutPressed()
}

class ContainerView: UIView {
    
    var delegate: CheckoutButtonDelegate?

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
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        button.addTarget(self, action: #selector(checkoutPressed), for: .touchUpInside)
        return button
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
        
        [dividerImage, totalLabel, priceLabel, checkoutButton].forEach {
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
    }

    // MARK: - Public

    public func setup(with totalSum: Int) {
        priceLabel.text = "\(totalSum) ₸"
    }
    
    // MARK: - Action
    
    @objc func checkoutPressed() {
        self.delegate?.checkoutPressed()
    }
}
