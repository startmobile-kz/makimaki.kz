//
//  DishViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 13.06.2023.
//

import UIKit
import SnapKit

final class DishViewController: UIViewController {
    
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
        label.text = "Medium Supremo Pizza"
        label.textAlignment = .left
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Pepperoni, mushrooms, salami, onions, bell peppers, sausage, and olives."
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s15()
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        //        let blueOcean = UIColor(red: 20, green: 80, blue: 95, alpha: 1)
        //        let stepper = RoundStepper(viewData: .init(color: blueOcean, minimum: 0, maximum: 100, stepValue: 10))
        //        stepper.translatesAutoresizingMaskIntoConstraints = false
        //        stepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
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
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        [
            dishImageView,
            productNameLabel,
            descriptionLabel,
            stepper,
            addButton
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        dishImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-30)
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
            make.height.equalTo(37) //36
        }
        
        stepper.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-29)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(53)
            make.width.equalTo(135)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-29)
            make.leading.equalTo(stepper.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            
        }
    }
}
