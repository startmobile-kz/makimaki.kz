//
//  OrdersTableFooterView.swift
//  maki-maki-ios
//
//  Created by siberianarg on 06.06.2023.
//

import UIKit
import SnapKit

protocol OrdersTableFooterViewDelegate: AnyObject {
    func onReorderButtonPressed()
}

final class OrdersTableFooterView: UIView {
    
    // MARK: - Delegate
    
    weak var delegate: OrdersTableFooterViewDelegate?
    
    // MARK: - UI
    
    private lazy var reorderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.grey100.uiColor
        button.setTitle("REORDER", for: .normal)
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(reorder), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = AppColor.background.uiColor
        addSubview(reorderButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        reorderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Acton
    
    @objc func reorder() {
        self.delegate?.onReorderButtonPressed()
    }
}
