//
//  StepperView.swift
//  maki-maki-ios
//
//  Created by siberianarg on 15.06.2023.
//

import UIKit
import SnapKit

final class StepperView: UIView {
    
    // MARK: - UI
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        return button
    }()
    
    private lazy var countlabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.medium.s15()
        return label
    }()
    
    private lazy var upButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
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
        addSubviews([decreaseButton, countlabel, upButton])
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        decreaseButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
        
        countlabel.snp.makeConstraints { make in
            make.leading.equalTo(decreaseButton.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
        }
        
        upButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-19)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 135, height: 53)
    }
}
