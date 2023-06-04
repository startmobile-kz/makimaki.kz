//
//  AccountListCell.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 04.06.2023.
//

import UIKit
import SnapKit

class AccountListCell: UITableViewCell {

    // MARK: - UI
    
    private lazy var listImageView = UIImageView()
    
    private lazy var arrowImageView = UIImageView()
    
    private lazy var listTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(logo: Logo) {
        listImageView.image = logo.image
        listTitleLabel.text = logo.title
        arrowImageView.image = logo.arrow
    }
    
    // MARK: - Set UI
    func setUI() {
        addSubview(listImageView)
        addSubview(listTitleLabel)
        addSubview(arrowImageView)
    }

    // MARK: - Setup Constraints
    func constraints() {
        listImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(24)
        }
        
        listTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(listImageView.snp.centerY)
            make.leading.equalTo(listImageView.snp.trailing).offset(16)
        }

        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
