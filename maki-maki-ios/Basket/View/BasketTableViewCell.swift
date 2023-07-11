//
//  BasketTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 01.06.2023.
//

import UIKit
import SnapKit

protocol BasketTableViewCellDelegate: AnyObject {
    func deleteButtonTapped(at indexPath: IndexPath)
}

protocol BasketTableViewCellProtocol: AnyObject {
    var presenter: BasketPresenter? { get set }
    func setupData(dish: RestaurantProduct)
}

final class BasketTableViewCell: UITableViewCell, BasketTableViewCellProtocol {
    
    var presenter: BasketPresenter?
    
    static let reuseIdentifier = String(describing: BasketTableViewCell.self)
    
    // MARK: - UI
    
    weak var delegate: BasketTableViewCellDelegate?
    private var indexPath: IndexPath?
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "orderImage")
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        label.sizeToFit()
        return label
    }()
    
    private lazy var priceOrderLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.paragraph.uiColor
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
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
        contentView.addSubview(productImageView)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceOrderLabel)
        contentView.addSubview(deleteButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(quantityLabel.snp.trailing).offset(10)
            make.width.equalTo(101)
        }
        
        priceOrderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
    
    // MARK: - Logic
    
    @objc private func deleteButtonTapped() {
        if let indexPath = indexPath {
            delegate?.deleteButtonTapped(at: indexPath)
        }
    }
    
    func configure(with product: RestaurantProduct, at indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func setupData(dish: RestaurantProduct) {
        let url = URL(string: dish.image ?? "")
        productImageView.kf.setImage(with: url)
        quantityLabel.text = "\(dish.count) X"
        productNameLabel.text = dish.name
        priceOrderLabel.text = "\(dish.count * dish.price) ₸"
    }
}
