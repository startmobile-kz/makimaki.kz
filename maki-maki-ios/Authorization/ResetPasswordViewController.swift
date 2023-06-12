//
//  ResetPasswordViewController.swift
//  maki-maki-ios
//
//  Created by Darkhan on 08.06.2023.

import UIKit
import SnapKit
import SkyFloatingLabelTextField

final class ResetPasswordViewController: UIViewController {
    
    // MARK: - UI elements design
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter new password and confirm."
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.paragraph.uiColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var newPasswordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.font = AppFont.reqular.s15()
        textField.title = "NEW PASSWORD"
        textField.placeholder = "Password"
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.blue.uiColor
        textField.selectedTitleColor = AppColor.blue.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 0.5
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        let imageView = UIImageView()
        let image = AppImage.eye.uiImage
        imageView.image = image
        textField.rightView = imageView
        return textField
    }()
    
    private lazy var confirmPasswordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.font = AppFont.reqular.s15()
        textField.title = "CONFIRM PASSWORD"
        textField.placeholder = "Repeat Password"
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.blue.uiColor
        textField.selectedTitleColor = AppColor.blue.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 0.5
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        let imageView = UIImageView()
        let image = AppImage.eye.uiImage
        imageView.image = image
        textField.rightView = imageView
        return textField
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHANGE PASSWORD", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = AppColor.accent.uiColor
        return button
    }()
    
    private lazy var textFieldsContainer: UIStackView = {
        let vrStackView = UIStackView(arrangedSubviews: [newPasswordTextField, confirmPasswordTextField])
        vrStackView.axis = .vertical
        vrStackView.spacing = 24
        vrStackView.distribution = .fillEqually
        return vrStackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setUpViews()
        setUpConstraints()
    }
    
    private func setupNavigation() {
        title = "Reset Password"
    }
    
    // MARK: - Setup Views
    private func setUpViews() {
        view.backgroundColor = AppColor.background.uiColor
        [subtitleLabel, textFieldsContainer, changePasswordButton].forEach {
            view.addSubview($0)
        }
    }
    // MARK: - Setup Constraints
    private func setUpConstraints() {
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        confirmPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        textFieldsContainer.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(41)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsContainer.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
}
