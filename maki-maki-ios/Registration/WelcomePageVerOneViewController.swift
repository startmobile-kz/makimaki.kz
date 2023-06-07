//
//  WelcomePageVerOneViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 01.06.2023.
//

import UIKit
import SnapKit

final class WelcomePageVerOneViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var makiImage: UIImageView = {
        let imageView = UIImageView()
        let bgImg = UIImage(named: "welcomeImg")
        imageView.image = bgImg
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var welcomeView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.background.uiColor
        view.layer.cornerRadius = 14
        return view
    }()
    
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

     private lazy var phoneNumberTextField: UITextField = {
         let textField = UITextField()
         textField.placeholder = "+7 7082020155"
         textField.textColor = AppColor.heading.uiColor
         textField.borderStyle = .none
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
        return button
     }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpViews()
    }
    
    // MARK: - Setup Views
    private func setUpViews() {
        self.phoneNumberTextField.addBottomBorder()
        [makiImage, welcomeView].forEach {
            view.addSubview($0)
        }
        [welcomeLabel, subtitleLabel, phoneNumberTextField, continueButton].forEach {
            welcomeView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setUpConstraints() {
        makiImage.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
        }
        
        welcomeView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(330)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.leading.equalTo(welcomeView).offset(16)
            make.top.equalTo(welcomeView).offset(25)
            make.height.equalTo(40)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(welcomeView).offset(16)
            make.trailing.equalTo(welcomeView).offset(-16)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(13)
        }

        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.leading.equalTo(welcomeView).offset(16)
            make.trailing.equalTo(welcomeView).offset(-16)
            make.height.equalTo(60)
        }

        continueButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(32)
            make.leading.equalTo(welcomeView).offset(16)
            make.trailing.equalTo(welcomeView).offset(-16)
            make.height.equalTo(53)
        }
    }
}
