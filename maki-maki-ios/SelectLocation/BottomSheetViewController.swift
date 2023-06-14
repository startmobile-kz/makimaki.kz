//
//  File.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 14.06.2023.
//

import UIKit
import SnapKit

final class BottomSheetViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var selectLocationLabel: UILabel = {
       let label = UILabel()
        label.text = "Select Location"
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s24()
        return label
    }()
    
    lazy var yourLocationLabel: UILabel = {
       let label = UILabel()
        label.text = "YOUR LOCATION"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s12()
        return label
    }()
    
    lazy var locationTextField = OneLineTextField()
    
    lazy var saveAsLabel: UILabel = {
       let label = UILabel()
        label.text = "Save As"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s12()
        return label
    }()
    
    lazy var saveAsSegmentedController = UISegmentedControl(first: "Home", second: "Work", third: "Other")
    
    private lazy var saveAddressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE ADDRESS", for: .normal)
        button.tintColor = AppColor.heading.uiColor
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        return button
        }()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupViews()
        constraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(selectLocationLabel)
        view.addSubview(yourLocationLabel)
        view.addSubview(locationTextField)
        view.addSubview(saveAsLabel)
        view.addSubview(saveAsSegmentedController)
        view.addSubview(saveAddressButton)
    }
    
    // MARK: - Constraints
    private func constraints() {
        selectLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(27)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        yourLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(selectLocationLabel.snp.bottom).offset(26)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(yourLocationLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        saveAsLabel.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(45)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        saveAsSegmentedController.snp.makeConstraints { make in
            make.top.equalTo(saveAsLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        saveAddressButton.snp.makeConstraints { make in
            make.top.equalTo(saveAsSegmentedController.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
}
