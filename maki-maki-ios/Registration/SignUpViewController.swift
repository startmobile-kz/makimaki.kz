//
//  SignUpViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 01.06.2023.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    // MARK: - Setup UI Components
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = AppFont.bold.s32()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.reqular.s15()
        textField.textAlignment = .left
        textField.text = "Islam"
        textField.textColor = AppColor.heading.uiColor
        textField.borderStyle = .none
        textField.rightViewMode = .always
        let imageView = UIImageView()
        let image = AppImage.check.uiImage
        imageView.image = image
        textField.rightView = imageView
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.reqular.s15()
        textField.textAlignment = .left
        textField.text = "aitemr@mail.com"
        textField.textColor = AppColor.heading.uiColor
        textField.borderStyle = .none
        textField.rightViewMode = .always
        let imageView = UIImageView()
        let image = AppImage.check.uiImage
        imageView.image = image
        textField.rightView = imageView
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.reqular.s15()
        textField.textAlignment = .left
        textField.isSecureTextEntry = true
        textField.textColor = AppColor.heading.uiColor
        textField.text = "**********"
        textField.borderStyle = .none
        textField.rightViewMode = .always
        let imageView = UIImageView()
        let image = AppImage.eye.uiImage
        imageView.image = image
        textField.rightView = imageView
        return textField
    }()
    
    private lazy var textFieldsContainer: UIStackView = {
        let vrStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField])
        vrStackView.axis = .vertical
        vrStackView.spacing = 23.5
        vrStackView.distribution = .fillEqually
        return vrStackView
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
    }
     
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        self.navigationController?.isNavigationBarHidden = true
        self.emailTextField.addBottomBorder()
        self.nameTextField.addBottomBorder()
        self.passwordTextField.addBottomBorder()
        [signUpLabel, textFieldsContainer, signUpButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        signUpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(93)
            make.leading.equalToSuperview().offset(16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        textFieldsContainer.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(41)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsContainer.snp.bottom).offset(31.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    
    // MARK: - Actions
    
    @objc private func signUpButtonDidPressed() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
}
