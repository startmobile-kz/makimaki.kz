//
//  ReorderCell.swift
//  maki-maki-ios
//
//  Created by siberianarg on 27.06.2023.
//

import UIKit
import SnapKit

protocol ReorderCellDelegate: AnyObject {
    func onReorderButtonPressed()
}

final class ReorderCell: UITableViewCell {
    
    // MARK: - State
    
    static let reuseID = String(describing: ReorderCell.self)
    
    // MARK: - Delegate
    
    weak var delegate: ReorderCellDelegate?
    
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.backgroundColor = AppColor.background.uiColor
        contentView.addSubview(reorderButton)
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
    
    // MARK: - Action
    
    @objc func reorder() {
        self.delegate?.onReorderButtonPressed()
    }
}
