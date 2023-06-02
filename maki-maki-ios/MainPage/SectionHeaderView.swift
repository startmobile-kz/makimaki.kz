//
//  SectionHeaderView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 01.06.2023.
//

import UIKit
import SnapKit

final class SectionHeaderView: UICollectionReusableView {
    
    static let reuseID = String(describing: SectionHeaderView.self)
    
    //MARK: -UI
    var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .label
         label.font = AppFont.semibold.s24()
         label.sizeToFit()
         return label
     }()
    
    //MARK: -Lifecycle
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
         setupConstraints()
    }
    
    private func setupViews() {
        addSubview(label)
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
