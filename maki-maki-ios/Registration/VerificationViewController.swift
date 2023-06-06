//
//  VerificationViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 01.06.2023.
//

import UIKit
import SnapKit

final class VerificationViewController: UIViewController {
    // MARK: - Setup UI Elements
    private lazy var otplabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your OTP code here"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s15()
        return label
    } ()
    
    private lazy var otpTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.semibold.s20()
        textField.textColor = AppColor.heading.uiColor
        textField.text = "4 5 6 7 5 7"
        textField.textAlignment = .center
        textField.defaultTextAttributes.updateValue(20.0, forKey: NSAttributedString.Key.kern)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private lazy var otpStatusMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Didn't receive the OTP?"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        label.textAlignment = .right
        return label
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESEND", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s14()
        button.setTitleColor(AppColor.blue.uiColor, for: .normal)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let hrStackView = UIStackView(arrangedSubviews: [otpStatusMessageLabel, resendButton])
        hrStackView.axis = .horizontal
        hrStackView.spacing = 4
        hrStackView.distribution = .fillProportionally
        return hrStackView
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("VERIFY", for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(verifyButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        [otplabel, otpTextField, horizontalStackView, verifyButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Verification"
        navigationItem.leftBarButtonItem
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        otplabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(187)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        otpTextField.snp.makeConstraints { make in
            make.top.equalTo(otplabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(34)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(otpTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(143)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        verifyButton.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(52)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    // MARK: - Actions
    @objc private func verifyButtonDidPressed() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
}
