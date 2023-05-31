//
//  ProfileEditingViewController.swift
//  maki-maki-ios
//
//  Created by Ravil on 30.05.2023.
//

import UIKit
import SnapKit

class ProfileEditingViewController: UIViewController {

    // MARK: - UI
    
    lazy var arrowLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("<", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = "man.png"
        let image = UIImage(named: imageView)
        let profileImageView = UIImageView(image: image!)
        return profileImageView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE", for: .normal)
        button.backgroundColor = .yellow
        button.tintColor = .black
        button.layer.cornerRadius = 14
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        title = "Profile"
        edgesForExtendedLayout = []
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(arrowLeftButton)
        view.addSubview(profileLabel)
        view.addSubview(profileImageView)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(phoneTextField)
        view.addSubview(saveButton)
    }
    
    private func setupContraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().inset(119)
            make.right.equalToSuperview().inset(126)
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
