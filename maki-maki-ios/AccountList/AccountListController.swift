//
//  ViewController.swift
//  AccountList
//
//  Created by Ravil on 03.06.2023.
//

import UIKit
import SnapKit

class AccountListController: UIViewController {
    
    private lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "profile-image-accountlist.pdf")
        return profileImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Islam Temirbek"
        nameLabel.font = AppFont.bold.s24()
        return nameLabel
    }()
    
    private lazy var signOutButton: UIButton = {
        let signOutButton = UIButton(type: .system)
        signOutButton.setTitle("SIGNOUT", for: .normal)
        signOutButton.backgroundColor = AppColor.grey100.uiColor
        signOutButton.tintColor = AppColor.heading.uiColor
        signOutButton.layer.cornerRadius = 14
        return signOutButton
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(signOutButton)
    }
    
    // MARK: - Setup Constraints

    private func setupConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.size.equalTo(48)
            make.leading.equalToSuperview().offset(16)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
            make.centerY.equalTo(profileImage)
        }
        signOutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(-118)
            make.height.equalTo(53)
        }
    }
}
