//
//  StepperView.swift
//  maki-maki-ios
//
//  Created by siberianarg on 15.06.2023.
//

import UIKit
import SnapKit

final class StepperView: UIView {
    
    private var counter: Int
    
    // MARK: - UI
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        button.addTarget(self, action: #selector(decreaseButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.medium.s15()
        return label
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        button.addTarget(self, action: #selector(increaseButtonDidPressed), for: .touchUpInside)
        return button
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
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubviews([decreaseButton, countLabel, increaseButton])
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        decreaseButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(decreaseButton.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
        }
        
        increaseButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-19)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
    
    // MARK: - Decrease Counter Action
    
    @objc func decreaseButtonDidPressed() {
        var count = 0
        countLabel.text = "\(count)"
    }
    
    // MARK: - Increase Counter Action
    
    @objc func increaseButtonDidPressed() {
        var count = 2
        countLabel.text = "\(count)"
    }
    
    // MARK: - Intrinsic Stepper Size
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 135, height: 53)
    }
}
