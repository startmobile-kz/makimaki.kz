//
//  AccountCardsViewController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 31.05.2023.
//

import UIKit
import SnapKit

class AccountCardsViewController: UIViewController {
        
    // MARK: - UI
    lazy var circleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "#1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "Islam Temirbek"
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(700))
        label.tintColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return label
    }()
    
    lazy var buttonSignOut: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGNOUT", for: .normal)
        button.backgroundColor = UIColor(red: 242/255, green: 243/255, blue: 245/255, alpha: 1)
        button.tintColor = .black
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var ordersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Orders"), for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 102/255, alpha: 1)
        button.tintColor = .black
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var ordersLabel: UILabel = {
        let label = UILabel()
        label.text = "Orders"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.tintColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return label
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "user"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        button.layer.borderWidth = 0.4
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return label
    }()
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Like"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        button.layer.borderWidth = 0.4
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return label
    }()
    
    lazy var offersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Offer"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        button.layer.borderWidth = 0.4
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var offersLabel: UILabel = {
        let label = UILabel()
        label.text = "Offers"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return label
    }()
    
    lazy var paymentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Payment"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        button.layer.borderWidth = 0.4
        return button
    }()
    
    lazy var paymentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Payments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return label
    }()
    
    lazy var addressesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Location"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        button.layer.borderWidth = 0.4
        return button
    }()
    
    lazy var addressesLabel: UILabel = {
        let label = UILabel()
        label.text = "Addresses"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return label
    }()
    
    lazy var stackViewHorizontalOne: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [ordersButton, profileButton, favoritesButton])
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var stackViewHorizontalTwo: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [offersButton, paymentsButton, addressesButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        return stackView
    }()
    
    lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewHorizontalOne, stackViewHorizontalTwo])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 52
        return stackView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(circleImageView)
        view.addSubview(buttonSignOut)
        view.addSubview(userLabel)
        view.addSubview(ordersButton)
        view.addSubview(ordersLabel)
        view.addSubview(profileButton)
        view.addSubview(profileLabel)
        view.addSubview(favoritesButton)
        view.addSubview(favoritesLabel)
        view.addSubview(offersButton)
        view.addSubview(offersLabel)
        view.addSubview(addressesButton)
        view.addSubview(addressesLabel)
        view.addSubview(paymentsButton)
        view.addSubview(paymentsLabel)
        view.addSubview(allStackView)
    }
    
    // MARK: - Setup Constraints
    private func setupContraints() {
        circleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(84)
            make.centerX.equalToSuperview()
        }
        
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(circleImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        ordersButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }
        
        ordersLabel.snp.makeConstraints { make in
            make.top.equalTo(ordersButton.snp.bottom).offset(5)
            make.centerX.equalTo(ordersButton.snp.centerX)
        }
        
        profileButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(5)
            make.centerX.equalTo(profileButton.snp.centerX)
        }
        
        favoritesButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }
        
        favoritesLabel.snp.makeConstraints { make in
            make.top.equalTo(favoritesButton.snp.bottom).offset(5)
            make.centerX.equalTo(favoritesButton.snp.centerX)
        }
        
        offersButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }
        
        offersLabel.snp.makeConstraints { make in
            make.top.equalTo(offersButton.snp.bottom).offset(5)
            make.centerX.equalTo(offersButton.snp.centerX)
        }
        
        
        addressesButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }
        
        addressesLabel.snp.makeConstraints { make in
            make.top.equalTo(addressesButton.snp.bottom).offset(5)
            make.centerX.equalTo(addressesButton.snp.centerX)
        }
        
        paymentsButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }
        
        paymentsLabel.snp.makeConstraints { make in
            make.top.equalTo(paymentsButton.snp.bottom).offset(5)
            make.centerX.equalTo(paymentsButton.snp.centerX)
        }
        
//        profileButton.snp.makeConstraints { make in
//            make.width.height.equalTo(70)
//        }
        
        allStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(42.5)
            make.trailing.equalToSuperview().offset(-42.5)
            make.top.equalTo(userLabel.snp.bottom).offset(40)
        }
        
        buttonSignOut.snp.makeConstraints { make in
            make.top.equalTo(allStackView.snp.bottom).offset(132)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
        
    }
}
