//
//  StepperView.swift
//  maki-maki-ios
//
//  Created by siberianarg on 15.06.2023.
//

import UIKit
import SnapKit

final class StepperView: UIControl {
    
    var currentValue = 1 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    
    // MARK: - UI
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        button.addTarget(self, action: #selector(buttonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentStepValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(currentValue)"
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
        button.addTarget(self, action: #selector(buttonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(count: Int) {
        super.init(frame: .zero)
        currentStepValueLabel.text = String(count)
        currentValue = count
        setupViews()
        setupConstraints()
    }
    
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
        addSubviews([decreaseButton, currentStepValueLabel, increaseButton])
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        decreaseButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
        
        currentStepValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(decreaseButton.snp.trailing).offset(28)
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
        }
        
        increaseButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-19)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
    
    // MARK: - Button Action
    
    @objc func buttonDidPressed(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
    
    // MARK: - Intrinsic Stepper Size
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 135, height: 53)
    }
}
