//
//  RecentHeaderView.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 30.06.2023.
//

import UIKit
import SnapKit

class RecentHeaderView: UIView {
    
    // MARK: - UI
    
    private lazy var recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Searches"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
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
    
    // MARK: - SetupViews
    
    private func setupViews() {
        self.addSubview(recentSearchLabel)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(16)
            make.height.equalTo(18)
            make.width.equalTo(200)
        }
    }
    
}
