//
//  VerificationViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 01.06.2023.
//

import UIKit
import SnapKit
import CHIOTPField

final class VerificationViewController: UIViewController {
    
    private var timeRemaining: Int = 59
    private var timer: Timer?
    
    // MARK: - Setup UI Elements
    private lazy var otplabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your OTP code here"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s15()
        return label
    }()
    
    private lazy var otpTextField: CHIOTPFieldFour = {
        let textField = CHIOTPFieldFour()
        textField.font = AppFont.semibold.s20()
        textField.numberOfDigits = 4
        textField.spacing = 19
        textField.borderHeight = 2
        textField.borderColor = AppColor.accent.uiColor
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        return textField
    }()
        
    private func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil ,
            repeats: true
        )
        resendButton.isEnabled = false
    }
    
    private func timeFormatter(_ seconds: Int) -> String {
        let minute = Int(timeRemaining) / 60 % 60
        let second = Int(timeRemaining) % 60
        return String(format: "%02i:%02i", minute, second)
    }
    
    private lazy var otpStatusMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Time remaining: \(timeFormatter(timeRemaining))"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        label.textAlignment = .right
        return label
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESEND", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s14()
        button.setTitleColor(AppColor.grey300.uiColor, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let hrStackView = UIStackView(arrangedSubviews: [otpStatusMessageLabel, resendButton])
        hrStackView.axis = .horizontal
        hrStackView.spacing = 4
        hrStackView.distribution = .fillProportionally
        return hrStackView
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("VERIFY", for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(verifyButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    deinit {
        print("DEINITED: \(self)")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        [otplabel, otpTextField, horizontalStackView, verifyButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Verification"
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        otplabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(187)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        otpTextField.snp.makeConstraints { make in
            make.top.equalTo(otplabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(34)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(otpTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(143)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        verifyButton.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(52)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    // MARK: - Actions
    @objc private func verifyButtonDidPressed() {
        let controller = Main2TabBarController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
//        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func updateTime() {
        if timeRemaining >= 0 {
            otpStatusMessageLabel.text = "Time remaining: \(timeFormatter(timeRemaining))"
            timeRemaining -= 1
        } else {
            timer?.invalidate()
            resendButton.isEnabled = true
            resendButton.setTitleColor(AppColor.blue.uiColor, for: .normal)
        }
    }
    
    @objc private func resetTimer() {
        timeRemaining = 59
        startTimer()
    }
}
