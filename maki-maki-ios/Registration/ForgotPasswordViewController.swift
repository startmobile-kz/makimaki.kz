//
//  ForgotPasswordViewController.swift
//  maki-maki-ios
//
//  Created by Darkhan on 06.06.2023.
////
//  ForgotPasswordViewController.swift
//  maki-maki-ios
//
//  Created by Darkhan on 03.06.2023.
//

import UIKit
import SnapKit

final class ForgotPasswordViewController: UIViewController {

    // MARK: - UI Components
    
    
     private lazy var suggestionLabel: UILabel = {
         let label = UILabel()
         label.text = "Please enter your email address. You will receive a link to create a new password via email"
         label.font = AppFont.reqular.s15()
         label.textColor = AppColor.paragraph.uiColor
         label.numberOfLines = 0
         label.lineBreakMode = .byWordWrapping
         return label
     }()

     private lazy var mailTextfield: UITextField = {
         let textField = UITextField()
         textField.placeholder = "Enter your mail"
         textField.textColor = AppColor.heading.uiColor
         textField.borderStyle = .none
         return textField
     }()

     private lazy var sendButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("CONTINUE", for: .normal)
         button.setTitleColor(AppColor.heading.uiColor, for: .normal)
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
        view.backgroundColor = AppColor.background.uiColor
        [suggestionLabel, mailTextfield, sendButton].forEach {
          view.addSubview($0)
        }
    }

    // MARK: - Setup Constraints
    private func setUpConstraints() {
    

        

        suggestionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(78)
        }

        mailTextfield.snp.makeConstraints { make in
            make.top.equalTo(suggestionLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }

        sendButton.snp.makeConstraints { make in
            make.top.equalTo(mailTextfield.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
}
