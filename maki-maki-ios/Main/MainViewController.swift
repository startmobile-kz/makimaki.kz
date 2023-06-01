//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 01.06.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var deliverToLabel: UILabel = {
        
        let label = UILabel()
        label.text = "DELIVER TO"
        label.font = UIFont(name: AppFont.semibold.rawValue, size: 15)
        label.textColor = UIColor(named: AppColor.darkOrange.rawValue)
        return label
        
    }()
    
    private lazy var addressButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Navoi 37 >", for: .normal)
        button.setTitleColor(UIColor(named: AppColor.heading.rawValue), for: .normal)
        button.titleLabel?.font = UIFont(name: AppFont.reqular.rawValue, size: 15)

        return button
        
    }()
    
    private lazy var separator: UIView = {
       
        let separator = UIView()
        separator.backgroundColor = UIColor(named: AppColor.border.rawValue)
        return separator
        
    }()
    
    private lazy var categoryStackView: UIStackView = {
        
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.addArrangedSubview(categoryButton)
        stackView.addArrangedSubview(categoryLabel)
        return stackView
        
        
    }()
    
    private lazy var categoryButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "burger"), for: .normal)
        button.backgroundColor = UIColor(named: AppColor.accent.rawValue)
        button.layer.cornerRadius = 20
        return button
        
    }()
    
    private lazy var categoryLabel: UILabel = {
       
        let label = UILabel()
        label.text = "Burgers"
        label.font = UIFont(name: AppFont.reqular.rawValue, size: 12)
        label.textColor = UIColor(named: AppColor.paragraph.rawValue)
        return label
        
    }()
    
    
    private lazy var promoLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Promo"
        label.font = UIFont(name: AppFont.semibold.rawValue, size: 22)
        label.textColor = UIColor(named: AppColor.heading.rawValue)
        return label
        
    }()
    
    private lazy var promoButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "Promo1"), for: .normal)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraintsWithSnapKit()
    }
    
    
    // MARK: - Setup Views
    
    private func setupViews() {
        
        
        view.backgroundColor = UIColor(named: AppColor.background.rawValue)
        
        view.addSubview(deliverToLabel)
        view.addSubview(addressButton)
        view.addSubview(separator)
        view.addSubview(categoryStackView)
        view.addSubview(promoLabel)
        view.addSubview(promoButton)
        
        
    }
    
    
    
    // MARK: - Setup Constraints
    private func setupConstraintsWithSnapKit() {
        
        deliverToLabel.snp.makeConstraints { make in
            make.top.equalTo(62)
            make.leading.equalTo(16)
        }
        
        addressButton.snp.makeConstraints { make in
            make.top.equalTo(deliverToLabel.snp.bottom).offset(5)
            make.leading.equalTo(16)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(addressButton.snp.bottom).offset(20)
            make.height.equalTo(0.5)
            make.leading.trailing.equalTo(0)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.height.width.equalTo(70)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(5)
        }
        
        categoryStackView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(28)
            make.leading.equalTo(16)
            
            
        }
        
        promoLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryStackView.snp.bottom).offset(40.5)
            make.leading.equalTo(16)
        }
        
        promoButton.snp.makeConstraints { make in
            make.top.equalTo(promoLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.width.equalTo(300)
            make.height.equalTo(160)
        }
        
    }

}
