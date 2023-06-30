//
//  SecondMainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 30.06.2023.
//

import UIKit
import SnapKit

class SecondMainViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var deliveryHeaderView: DeliveryHeaderView = {
        let view = DeliveryHeaderView()
        view.delegate = self
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.border.uiColor
        return view
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - SetupView
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([deliveryHeaderView, separatorView])
    }
    
    // MARK: - SetupLayout
    
    private func setupConstraints() {
        deliveryHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(deliveryHeaderView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

extension SecondMainViewController: DeliveryHeaderViewDelegate {
    func viewWasTapped() {
        print("Tapped")
    }
}
