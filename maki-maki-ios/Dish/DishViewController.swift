//
//  DishViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 13.06.2023.
//

import UIKit
import SnapKit

protocol DishViewControllerDelegate: AnyObject {
    func addToBasket(dish: DishResponseModel)
}

final class DishViewController: UIViewController {
    
    // MARK: - State

    var dish: DishResponseModel?
    var count = 1

    // MARK: - Delegate
    
    weak var delegate: DishViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.pizza_image.uiImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s15()
        return label
    }()
    
    private lazy var stepperView: StepperView = {
        let stepper = StepperView()
        stepper.contentMode = .scaleAspectFill
        stepper.clipsToBounds = true
        stepper.layer.cornerRadius = 14
        stepper.backgroundColor = AppColor.grey100.uiColor
        stepper.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)
        return stepper
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.setTitle("ADD", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        button.addTarget(self, action: #selector(addButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var orderPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupData()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        [
            dishImageView,
            productNameLabel,
            descriptionLabel,
            stepperView,
            addButton,
            orderPrice
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        dishImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(304)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(dishImageView.snp.bottom).offset(44)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(29)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(37)
        }
        
        stepperView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-29)
            make.leading.equalToSuperview().offset(16)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-29)
            make.leading.equalTo(stepperView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
        
        orderPrice.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-29)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(53)
        }
        
    }
    
    // MARK: - Stepper Value Action
    
    @objc private func stepperChangedValueAction(sender: StepperView) {
        self.count = sender.currentValue
    }

    // MARK: - Button Action
    
    @objc private func addButtonDidPressed() {
        if let dish = dish {
            dish.isSelected = true
            dish.count = count
            delegate?.addToBasket(dish: dish)
            dismiss(animated: true)
        }
    }
    
    // MARK: - Setup Data

    private func setupData() {
        guard let dish = dish else {
            return
        }
        
        productNameLabel.text = dish.name
        descriptionLabel.text = "\(dish.description)"
        orderPrice.text = "\(dish.price) ₸"
        let url = URL(string: dish.image ?? "")
        dishImageView.kf.setImage(with: url)
    }
}
