//
//  ResetPasswordViewController.swift
//  maki-maki-ios
//
//  Created by Darkhan on 08.06.2023.

import UIKit
import SnapKit

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
    
    private lazy var newPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW PASSWORD"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.paragraph.uiColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "CONFIRM PASSWORD"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.paragraph.uiColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "**********"
        textField.textColor = AppColor.heading.uiColor
        textField.borderStyle = .none
        return textField
    }()
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "**********"
        textField.textColor = AppColor.heading.uiColor
        textField.borderStyle = .none
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
        view.backgroundColor = .white
        [subtitleLabel,
         newPasswordLabel,
         confirmPasswordLabel, newPasswordTextField,
         confirmPasswordTextField, changePasswordButton].forEach {
            view.addSubview($0)
        }
    }
    // MARK: - Setup Constraints
    private func setUpConstraints() {
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(13)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }

        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(23.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        newPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(43)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordLabel.snp.bottom).offset(29.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }

        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(29.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
}
