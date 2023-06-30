//
//  ViewController.swift
//  AccountList
//
//  Created by Ravil on 03.06.2023.
//

import UIKit
import SnapKit

class AccountListViewController: UIViewController {

    // MARK: - UI
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar-ac") // profile_image.pdf
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel? = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "name")
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGNOUT", for: .normal)
        button.backgroundColor = AppColor.grey100.uiColor
        button.tintColor = AppColor.heading.uiColor
        button.layer.cornerRadius = 14
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 53.5
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AccountListCell.self, forCellReuseIdentifier: "LogoCell")
        return tableView
    }()
    
    private var logos: [Logo] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()

        logos = fetchData()
        setupName()
        
    }
    
    // MARK: - setupName
    
    private func setupName() {
        if let name = UserDefaults.standard.string(forKey: "name") {
            nameLabel?.text = name
        } else {
            nameLabel?.text = ""
        }
    }
    
    // MARK: - Set UI
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor

        view.addSubview(profileImage)
        view.addSubview(nameLabel!)
        view.addSubview(tableView)
        view.addSubview(signOutButton)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(48)
            make.leading.equalToSuperview().offset(16)
        }

        nameLabel!.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage.snp.centerY)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }

        signOutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(-118)
            make.height.equalTo(53)
        }
    }
}

// MARK: - Extension

extension AccountListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "LogoCell",
            for: indexPath
        ) as? AccountListCell else {
            fatalError("Could not cast to CategoryCollectionViewCell")
        }
        let logo = logos[indexPath.row]
        cell.set(logo: logo)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var controller: UIViewController = UIViewController()
        if indexPath.row == 0 {
            controller = OrdersViewController()
        }

        if indexPath.row == 1 {
            controller = EditProfileViewController()
        }

        if indexPath.row == 2 {
            controller = FavoritesViewController()
        }

        if indexPath.row == 3 {
            controller = OffersViewController()
        }

        if indexPath.row == 4 {
            controller = PaymentsViewController()
        }

        if indexPath.row == 5 {
            controller = PaymentMethodViewController()
        }

//        present(controller, animated: true)

        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension AccountListViewController {
    func fetchData() -> [Logo] {
        let logo1 = Logo(image: AppImage.orders, title: "My Orders", arrow: AppImage.arrowRight)
        let logo2 = Logo(image: AppImage.user, title: "My Profile", arrow: AppImage.arrowRight)
        let logo3 = Logo(image: AppImage.like, title: "Favorites", arrow: AppImage.arrowRight)
        let logo4 = Logo(image: AppImage.offer, title: "Offers & Promos", arrow: AppImage.arrowRight)
        let logo5 = Logo(image: AppImage.payment, title: "Payments", arrow: AppImage.arrowRight)
        let logo6 = Logo(image: AppImage.location, title: "Location", arrow: AppImage.arrowRight)
        return [logo1, logo2, logo3, logo4, logo5, logo6]
    }
}
