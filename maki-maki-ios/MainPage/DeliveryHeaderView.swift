//
//  DeliveryHeaderView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 01.06.2023.
//

import UIKit
import SnapKit

final class DeliveryHeaderView: UICollectionReusableView {
    
    static let reuseID = String(describing: DeliveryHeaderView.self)
    
    //MARK: -UI
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
        button.setImage(AppImage.chevronDown.systemImage, for: .normal)
        button.tintColor = AppColor.paragraph.uiColor
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.border.uiColor
        return view
    }()
    
    //MARK: - Lifecycle
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
         setupConstraints()
    }
    
    private func setupViews() {
        addSubviews([deliverToLabel, addressLabel, chevronButton, separatorView])
    }
    
    private func setupConstraints() {
        deliverToLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(deliverToLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
        }
        
        chevronButton.snp.makeConstraints { make in
            make.centerY.equalTo(addressLabel.snp.centerY)
            make.leading.equalTo(addressLabel.snp.trailing).offset(7.4)
            make.width.equalTo(11.4)
            make.height.equalTo(6)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
