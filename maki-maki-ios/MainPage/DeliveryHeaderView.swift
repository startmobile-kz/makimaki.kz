//
//  DeliveryHeaderView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 01.06.2023.
//

import UIKit
import SnapKit

protocol DeliveryHeaderViewDelegate: AnyObject {
    func viewWasTapped()
}

final class DeliveryHeaderView: UIView {
    
    static let reuseID = String(describing: DeliveryHeaderView.self)
    
    // MARK: - UI
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
        button.setImage(AppImage.chevron_down.systemImage, for: .normal)
        button.tintColor = AppColor.paragraph.uiColor
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.border.uiColor
        return view
    }()
    
    // MARK: - Delegate
    weak var delegate: DeliveryHeaderViewDelegate?
    
    // MARK: - Lifecycle
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
         setupConstraints()
         setupGestureRecognizers()
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        addSubviews([deliverToLabel, addressLabel, chevronButton, separatorView])
    }
    
    // MARK: - SetupConstraints
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
            make.trailing.equalToSuperview().offset(16)
            make.height.equalTo(0.5)
        }
    }
    
    private func setupGestureRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc func viewWasTapped() {
        delegate?.viewWasTapped()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
