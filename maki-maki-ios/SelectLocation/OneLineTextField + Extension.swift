//
//  OneLineTextField.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 14.06.2023.
//

import UIKit
import SnapKit

final class OneLineTextField: UITextField {
    
    convenience init() {
        self.init(frame: .zero)
        
        self.font = AppFont.reqular.s15()
        self.textColor = AppColor.heading.uiColor
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = AppColor.border.uiColor
        
        self.addSubview(bottomView)

        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(12.5)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(1)
        }
            
    }
}
