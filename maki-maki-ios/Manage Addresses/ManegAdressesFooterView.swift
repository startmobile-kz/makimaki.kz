//
//  ManegAdressesFooterView.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import Foundation
import UIKit
import SnapKit

final class AddressTableViewFooterView: UITableViewHeaderFooterView {
    
    static let identifier = "TableFooter"
    
    public lazy var addNewAddressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD NEW ADDRESS", for: .normal)
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(addNewAddressButton)
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintUI() {
        addNewAddressButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    
    // MARK: - Actions
 
} 
