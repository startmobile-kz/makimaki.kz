//
//  NoOrdersViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 09.06.2023.
//

import UIKit
import SnapKit

final class NoOrdersViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var noOrdersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.no_orders.uiImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var noOrderslabel: UILabel = {
        let label = UILabel()
        label.text = "No Orders Yet!"
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var proposalLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover and place your first order"
        label.textAlignment = .center
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Orders"
        edgesForExtendedLayout = []
    }
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        [noOrdersImageView, noOrderslabel, proposalLabel].forEach { view.addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        noOrdersImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
            make.width.equalTo(111.41)
            make.height.equalTo(124)
        }
        
        noOrderslabel.snp.makeConstraints { make in
            make.top.equalTo(noOrdersImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        proposalLabel.snp.makeConstraints { make in
            make.top.equalTo(noOrderslabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
}
