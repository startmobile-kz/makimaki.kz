//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 31.05.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //MARK: -UI
//    private lazy var deliveryStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.spacing = 5
//
//        return stack
//    }()
    
    private lazy var deliverToLabel: UILabel = {
        let label = UILabel()
        label.text = "DELIVER TO"
        label.font = AppFont.semibold.s15()
        label.textColor = AppColor.darkOrange.uiColor
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Navoi 37"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        
        return label
    }()
    
    private lazy var chevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = AppColor.paragraph.uiColor
    
        return button
    }()
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        edgesForExtendedLayout = []
        let subviews = [deliverToLabel,addressLabel ,chevronButton]
        view.addSubviews(subviews)
       
    }
    
    private func setupConstraints() {
        deliverToLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(deliverToLabel.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        chevronButton.snp.makeConstraints { make in
            make.centerY.equalTo(addressLabel.snp.centerY)
            make.leading.equalTo(addressLabel.snp.trailing).offset(7.4)
            make.width.equalTo(11.4)
            make.height.equalTo(6)
        }
    }
}
