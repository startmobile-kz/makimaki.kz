//
//  AccountCardsViewController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 05.06.2023.
//

import UIKit
import SnapKit

final class AccountCardsViewController: UIViewController {

    // MARK: - UI
    private lazy var avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "avatar-ac")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "Islam Temirbek"
        label.font = AppFont.bold.s28()
        label.tintColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGNOUT", for: .normal)
        button.backgroundColor = AppColor.grey100.uiColor
        button.tintColor = .black
        button.layer.cornerRadius = 16
        return button
    }()

    private lazy var ordersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "orders-ac"), for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.tintColor = .black
        button.layer.cornerRadius = 16
        return button
    }()

    private lazy var ordersLabel: UILabel = {
        let label = UILabel()
        label.text = "Orders"
        label.font = AppFont.reqular.s12()
        label.textAlignment = .center
        label.tintColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "user-ac"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.borderWidth = 0.4
        button.layer.cornerRadius = 16
        return button
    }()

    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = AppFont.reqular.s12()
        label.tintColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like-ac"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.borderWidth = 0.4
        button.layer.cornerRadius = 16
        return button
    }()

    private lazy var favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = AppFont.reqular.s12()
        label.tintColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var offersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "offer-ac"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.borderWidth = 0.4
        button.layer.cornerRadius = 16
        return button
    }()

    private lazy var offersLabel: UILabel = {
        let label = UILabel()
        label.text = "Offers"
        label.font = AppFont.reqular.s12()
        label.tintColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var paymentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "payment-ac"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 0.4
        return button
    }()

    private lazy var paymentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Payments"
        label.font = AppFont.reqular.s12()
        label.tintColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var addressesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "location-ac"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 0.4
        return button
    }()

    private lazy var addressesLabel: UILabel = {
        let label = UILabel()
        label.text = "Addresses"
        label.font = AppFont.reqular.s12()
        label.tintColor = AppColor.heading.uiColor
        return label
    }()

    private lazy var stackViewHorizontalOne: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [ordersButton, profileButton, favoritesButton])
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var stackViewHorizontalTwo: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [offersButton, paymentsButton, addressesButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        return stackView
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewHorizontalOne, stackViewHorizontalTwo])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 32
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

        [avatarImageView, signOutButton, userLabel,
         ordersLabel, profileLabel,
         favoritesLabel, offersLabel,
         addressesLabel, paymentsLabel, buttonsStackView].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - Setup Constraints
    private func setupContraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(73)
            make.centerX.equalToSuperview()
        }

        userLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        ordersButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }

        ordersLabel.snp.makeConstraints { make in
            make.top.equalTo(ordersButton.snp.bottom).offset(5)
            make.centerX.equalTo(ordersButton.snp.centerX)
        }

        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(5)
            make.centerX.equalTo(profileButton.snp.centerX)
        }

        favoritesLabel.snp.makeConstraints { make in
            make.top.equalTo(favoritesButton.snp.bottom).offset(5)
            make.centerX.equalTo(favoritesButton.snp.centerX)
        }

        offersLabel.snp.makeConstraints { make in
            make.top.equalTo(offersButton.snp.bottom).offset(5)
            make.centerX.equalTo(offersButton.snp.centerX)
        }

        addressesLabel.snp.makeConstraints { make in
            make.top.equalTo(addressesButton.snp.bottom).offset(5)
            make.centerX.equalTo(addressesButton.snp.centerX)
        }

        paymentsLabel.snp.makeConstraints { make in
            make.top.equalTo(paymentsButton.snp.bottom).offset(5)
            make.centerX.equalTo(paymentsButton.snp.centerX)
        }

        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(42.5)
            make.trailing.equalToSuperview().offset(-42.5)
        }

        signOutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-118)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
}
