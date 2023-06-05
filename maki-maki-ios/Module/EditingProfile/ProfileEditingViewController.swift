//
//  ProfileEditingViewController.swift
//  maki-maki-ios
//
//  Created by Ravil on 30.05.2023.
//

import UIKit
import SnapKit

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
        imageView.image = UIImage(named: "UserAvatar.pdf")
        return imageView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
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
        title = "Profile"
        edgesForExtendedLayout = []
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [profileLabel, profileImageView, nameTextField, emailTextField, phoneTextField, saveButton].forEach {
            view.addSubview($0)
            }
    }
    
    private func setupContraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(119)
            make.centerX.equalToSuperview()
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(66)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(66)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(66)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(44.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    
}
