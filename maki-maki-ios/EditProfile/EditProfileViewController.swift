//
//  EditProfileViewController.swift
//  maki-maki-ios
//
//  Created by Ravil on 30.05.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import InputMask

final class EditProfileViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = AppColor.heading.uiColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.edit_avatar.uiImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        let imageView = UIImageView()
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 20
        button.setImage(AppImage.edit.uiImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        imageView.image = AppImage.edit.uiImage
        return button
    }()
    
    private lazy var nameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "NAME"
        textField.placeholder = "Islam"
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.blue.uiColor
        textField.selectedTitleColor = AppColor.blue.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 0.5
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        return textField
    }()
    
    private lazy var emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "EMAIL"
        textField.placeholder = "aitemr16@gmail.com"
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.blue.uiColor
        textField.selectedTitleColor = AppColor.blue.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 0.5
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    // MARK: - MaskedTextField Listener
    
    private lazy var listener: MaskedTextFieldDelegate = {
        let listener = MaskedTextFieldDelegate()
        listener.onMaskedTextChangedCallback = { textField, _, isFilled in
            let updatedText = textField.text ?? ""
            if isFilled {
                print("Text field is filled: \(updatedText)")
            }
        }
        listener.delegate = self
        listener.primaryMaskFormat = "+7 ([000]) [000] [00] [00]"
        return listener
    }()
    
    private lazy var phoneTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "PHONE"
        textField.placeholder = "+7 (777) 777 77 77"
        textField.delegate = listener
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
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE", for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.tintColor = .black
        button.layer.cornerRadius = 14
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Views
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Profile"
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [profileLabel,
         profileImageView,
         editButton,
         nameTextField,
         emailTextField,
         phoneTextField,
         saveButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupContraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(138)
            make.height.equalTo(130)
        }
        editButton.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.leading).offset(97.5)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(-90)
            make.size.equalTo(40)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(44.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    
}
