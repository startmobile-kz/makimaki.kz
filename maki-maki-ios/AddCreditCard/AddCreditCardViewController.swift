//
//  AddCreditCardViewController.swift
//  maki-maki-ios
//
//  Created by Darkhan on 23.06.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import InputMask

final class AddCreditCardViewController: UIViewController {
    
    // MARK: - Setup UI Components
    
    private lazy var creditCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    private lazy var mastercardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mastercard")
        return imageView
    }()
    
    private lazy var cardHolderLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s15()
        label.text = "CARD HOLDER"
        label.textColor = AppColor.grey300.uiColor
        return label
    }()
    
    private lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s18()
        label.text = "0000 0000 0000 0000"
        label.textColor = AppColor.background.uiColor
        return label
    }()
    
    private lazy var cardHolderNameLabel: UILabel = {
        let label = UILabel()
        label.text = "DARKHAN ASHKEN"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.background.uiColor
        return label
    }()
    
    private lazy var validThruLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.grey300.uiColor
        label.text = "VALID THRU"
        return label
    }()
    
    private lazy var dateOfExpireLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.background.uiColor
        label.text = "MM/YY"
        return label
    }()
    
    private lazy var cardHolderNameTextfield: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.font = AppFont.reqular.s15()
        textField.title = "CARD HOLDER NAME"
        textField.placeholder = "CARD HOLDER NAME"
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.grey300.uiColor
        textField.selectedTitleColor = AppColor.grey300.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 2
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        textField.delegate = self
        return textField
    }()
    
   private lazy var cardNumberTextfield: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        let imageView = UIImageView()
        let image = UIImage(named: "camera")
        let firstDigit = String((cardHolderNameTextfield.text?.prefix(1))!)
        textField.font = AppFont.reqular.s15()
        textField.title = "CARD NUMBER"
        textField.placeholder = "CARD NUMBER"
        textField.textColor = AppColor.heading.uiColor
        textField.lineColor = AppColor.border.uiColor
        textField.selectedLineColor = AppColor.grey300.uiColor
        textField.selectedTitleColor = AppColor.grey300.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 2
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        imageView.image = image
        textField.rightView = imageView
        let text = textField.text ?? ""
        let integer = Int(text) ?? 0
        print("Integer", integer)
        return textField
    }()
    
    private lazy var textFieldsContainer: UIStackView = {
        let vrStackView = UIStackView(arrangedSubviews: [cardHolderNameTextfield, cardNumberTextfield])
        vrStackView.axis = .vertical
        vrStackView.spacing = 23.5
        vrStackView.distribution = .fillEqually
        return vrStackView
    }()
    
    private lazy var textFieldsContainer2: UIStackView = {
        let vrStackView = UIStackView(arrangedSubviews: [dateOfExpireTextField, cvcTextField])
        vrStackView.axis = .horizontal
        vrStackView.spacing = 23.5
        return vrStackView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        return button
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
        listener.primaryMaskFormat = "[00]{/}[00]"
        return listener
    }()
    
    private lazy var dateOfExpireTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.font = AppFont.reqular.s15()
        textField.placeholder = "MM/YY"
        textField.delegate = listener
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.grey300.uiColor
        textField.selectedTitleColor = AppColor.grey300.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 2
        textField.keyboardType = .default
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var cvcTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.font = AppFont.reqular.s15()
        textField.placeholder = "CVC"
        textField.lineColor = AppColor.border.uiColor
        textField.textColor = AppColor.heading.uiColor
        textField.selectedLineColor = AppColor.grey300.uiColor
        textField.selectedTitleColor = AppColor.grey300.uiColor
        textField.selectedLineHeight = 2
        textField.lineHeight = 2
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        textField.delegate = self
        return textField
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints1()
        setupConstraints2()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        title = "Add payments"
        view.backgroundColor = AppColor.background.uiColor
        [creditCardImageView, textFieldsContainer, textFieldsContainer2, saveButton].forEach {
            view.addSubview($0)
            [cardNumberLabel, mastercardImageView,
             cardHolderLabel, cardHolderNameLabel, validThruLabel,
             dateOfExpireLabel ].forEach {
                creditCardImageView.addSubview($0)
            }
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints1() {
        creditCardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(122)
            make.height.equalTo(190)
            make.width.equalTo(300)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().inset(37)
        }
        
        cardNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(77)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-80)
        }
        
        cardHolderLabel.snp.makeConstraints { make in
            make.top.equalTo(cardNumberLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(25)
            make.right.lessThanOrEqualToSuperview().inset(25)
        }
        
        cardHolderNameLabel.snp.makeConstraints { make in
            make.top.equalTo(cardHolderLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(25)
            make.right.lessThanOrEqualTo(dateOfExpireLabel)
        }
        
        mastercardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(23)
            make.height.equalTo(31.1)
            make.width.equalTo(50)
        }
        
        validThruLabel.snp.makeConstraints { make in
            make.top.equalTo(mastercardImageView.snp.bottom).offset(73.92)
            make.right.equalToSuperview().offset(-22)
        }
        
        dateOfExpireLabel.snp.makeConstraints { make in
            make.top.equalTo(validThruLabel.snp.bottom).offset(6)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    private func setupConstraints2() {
        cardHolderNameTextfield.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        cardNumberTextfield.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        cvcTextField.snp.makeConstraints { make in
            make.width.equalTo(textFieldsContainer.snp.width).multipliedBy(0.5)
            make.height.equalTo(60)
        }
        
        textFieldsContainer.snp.makeConstraints { make in
            make.top.equalTo(creditCardImageView.snp.bottom).offset(41)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalTo(textFieldsContainer.snp.width).multipliedBy(0.5).offset(16)
        }
        
        textFieldsContainer2.snp.makeConstraints { make in
            make.top.equalTo(textFieldsContainer.snp.bottom).offset(37.5)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(dateOfExpireTextField.snp.bottom).offset(31.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
}

extension AddCreditCardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        cardHolderNameLabel.text = cardHolderNameTextfield.text
        dateOfExpireLabel.text = dateOfExpireTextField.text
        cardNumberLabel.text =
        cardNumberTextfield.text?.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})(\\d{4})",
                                                       with: "$1 $2 $3 $4",
                                                       options: .regularExpression, range: nil)
        let integer = cardNumberTextfield
        if integer.text?.first == "2" || integer.text?.first == "5" {
            mastercardImageView.image = UIImage(named: "visa")
        }
        if cvcTextField.text?.count == 3 && string.isEmpty {
            return true
        }
        return true
    }
}
