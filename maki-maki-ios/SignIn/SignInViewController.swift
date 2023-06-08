//  SignInViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 08.06.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

final class SignInViewController: UIViewController {
    
    // MARK: - Setup UI Components
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = AppFont.bold.s32()
        label.textColor = .black
        return label
    }()
    
    private lazy var emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.font = AppFont.reqular.s15()
        textField.title = "EMAIL"
        textField.placeholder = "Email"
        textField.textColor = AppColor.heading.uiColor
        textField.lineColor = AppColor.border.uiColor
        textField.selectedLineColor = AppColor.blue.uiColor
        textField.selectedTitleColor = AppColor.blue.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 0.5
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        let imageView = UIImageView()
        let image = AppImage.check.uiImage
        imageView.image = image
        textField.rightView = imageView
        return textField
    }()
    
    private lazy var passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.font = AppFont.reqular.s15()
        textField.title = "PASSWORD"
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
    
    private lazy var textFieldsContainer: UIStackView = {
        let vrStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        vrStackView.axis = .vertical
        vrStackView.spacing = 23.5
        vrStackView.distribution = .fillEqually
        return vrStackView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(signInButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CREATE ACCOUNT", for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.backgroundColor = AppColor.grey100.uiColor
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(createAccountButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsContainer: UIStackView = {
        let vrStackView = UIStackView(arrangedSubviews: [signInButton, createAccountButton])
        vrStackView.axis = .vertical
        vrStackView.spacing = 24
        vrStackView.distribution = .fillEqually
        return vrStackView
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(AppColor.blue.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.addTarget(self, action: #selector(forgotPasswordButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
     
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        navigationController?.isNavigationBarHidden = true
        [signInLabel, textFieldsContainer, buttonsContainer, forgotPasswordButton].forEach {
            view.addSubview($0)
        }
    }
        
    // MARK: - Setup Constraints
    private func setupConstraints() {
        signInLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(93)
            make.leading.equalToSuperview().offset(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        textFieldsContainer.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(41)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(53)
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.height.equalTo(53)
        }
        
        buttonsContainer.snp.makeConstraints { make in
            make.top.equalTo(textFieldsContainer.snp.bottom).offset(29.5)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-45)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func signInButtonDidPressed() {
        self.navigationController?.pushViewController(Main2TabBarController(), animated: true)
    }
    
    @objc private func createAccountButtonDidPressed() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc private func forgotPasswordButtonDidPressed() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
