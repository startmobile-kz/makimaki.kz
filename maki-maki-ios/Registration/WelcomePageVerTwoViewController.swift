//
//  WelcomePageViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 31.05.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import InputMask

final class WelcomePageVerTwoViewController: UIViewController {

    // MARK: - UI Components
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.font = AppFont.bold.s32()
        label.textColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In or Create Account to quickly manage orders"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.paragraph.uiColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - MaskedTextField Listener
//    private lazy var listener: MaskedTextFieldDelegate = {
//        let listener = MaskedTextFieldDelegate()
//        listener.onMaskedTextChangedCallback = { textField, _, isFilled in
//            let updatedText = textField.text ?? ""
//            if isFilled {
//                print("Text field is filled: \(updatedText)")
//            }
//        }
//        listener.delegate = self
//        listener.primaryMaskFormat = "+7 ([000]) [000] [00] [00]"
//        return listener
//    }()

    private lazy var phoneNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "PHONE NUMBER"
        textField.placeholder = "+7 (777) 777 77 77"
//        textField.delegate = listener
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.blue.uiColor
        textField.selectedTitleColor = AppColor.blue.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 0.5
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        return textField
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = AppColor.accent.uiColor
        button.addTarget(self, action: #selector(continueButtonDidPress), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }

    // MARK: - Setup Views
    private func setUpViews() {
        view.backgroundColor = .white
        [welcomeLabel,subtitleLabel,phoneNumberTextField,continueButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setUpConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(93)
            make.height.equalTo(40)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(13)
        }

        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }

        continueButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    
    // MARK: - Actions
    
    @objc private func continueButtonDidPress() {
        self.navigationController?.pushViewController(VerificationViewController(), animated: true)
    }
}
