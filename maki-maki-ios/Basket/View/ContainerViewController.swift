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
        button.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CheckoutButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(dividerImage)
        addSubview(totalLabel)
        addSubview(priceLabel)
        addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
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
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(53)
        }
        
    }
    
    func setup(with totalPrice: Int) {
        priceLabel.text = "\(totalPrice.formattedWithSeparator) ₸"
    }
    
    @objc private func checkoutButtonTapped() {
        delegate?.checkoutPressed()
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
