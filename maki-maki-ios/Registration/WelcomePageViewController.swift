//
//  WelcomePageViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 30.05.2023.
//

import UIKit
import SnapKit


final class WelcomePageViewController: UIViewController {
    
    // MARK: - UI elements design
   private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
       label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In or Create Account to quickly manage orders"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+7 7082020155"
        textField.borderStyle = .none
        return textField
    }()
    
   private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 102/255, alpha: 1)
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
        self.phoneNumberTextField.addBottomBorderWithColor(color: UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1), width: 0.5)
    }
    
    // MARK: - Setup Views
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(continueButton)
    }

    // MARK: - Setup Constraints
    private func setUpConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-202)
            make.top.equalToSuperview().offset(93)
            make.height.equalTo(40)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(13)
            make.height.equalTo(36)
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
}
 // MARK: - Extension for border bottom line
extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let borderBottomLine = CALayer()
        borderBottomLine.backgroundColor = color.cgColor
        borderBottomLine.frame = CGRect(x:0 ,y: self.frame.size.height - width,width: self.frame.size.width, height: width)
        self.layer.addSublayer(borderBottomLine)
    }
}
