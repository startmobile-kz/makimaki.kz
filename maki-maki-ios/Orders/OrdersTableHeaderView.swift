//
//  OrdersTableHeaderView.swift
//  maki-maki-ios
//
//  Created by siberianarg on 06.06.2023.
//

import UIKit
import SnapKit

protocol OrdersTableHeaderViewDelegate: AnyObject {
    func onCollapseMenuButtonDidPressed(section: Int)
}

final class OrdersTableHeaderView: UIView {
    
    static let identifier = String(describing: OrdersTableHeaderView.self)

    // MARK: - Delegate

    weak var delegate: OrdersTableHeaderViewDelegate?
    private var section: Int = 0

    // MARK: - UI
    
    private lazy var orderNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderStatusLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 6
        return label
    }()
    
    private lazy var orderDataLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.paragraph.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderPriceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dataPriceLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var dividerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.divider.uiImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public lazy var collapseMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.arrow_down.uiImage, for: .normal)
        button.backgroundColor = AppColor.background.uiColor
        button.tintColor = AppColor.heading.uiColor
        button.layer.borderWidth = 0.4
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self,
                         action: #selector(handleExpandClose),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = AppColor.background.uiColor

        [
            orderNameLabel,
            orderStatusLabel,
            dataPriceLabelsStackView,
            dividerImageView,
            collapseMenuButton
        ].forEach { addSubview($0) }

        [
            orderDataLabel,
            orderPriceLabel
        ].forEach { dataPriceLabelsStackView.addArrangedSubview($0) }
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        orderNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(22)
        }

        orderStatusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(29)
            make.width.equalTo(83)
        }

        dataPriceLabelsStackView.snp.makeConstraints { make in
            make.top.equalTo(orderNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(17)
        }

        dividerImageView.snp.makeConstraints { make in
            make.top.equalTo(dataPriceLabelsStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }

        collapseMenuButton.snp.makeConstraints { make in
            make.top.equalTo(dataPriceLabelsStackView.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }

    public func setUp(model: OrdersModel, section: Int) {
        self.section = section

        orderNameLabel.text = model.cafeName
        orderStatusLabel.text = model.status
        if model.status == "Delivered" {
            orderStatusLabel.backgroundColor = AppColor.green.uiColor
        } else {
            orderStatusLabel.backgroundColor = AppColor.red.uiColor
        }
        orderPriceLabel.text = model.price
        let dataComponents = [
            NSAttributedString(string: NSLocalizedString(model.time, comment: "Data"), attributes: [
                .foregroundColor: AppColor.paragraph.uiColor,
                .font: AppFont.reqular.s14()
            ]),
            NSAttributedString(string: NSLocalizedString("•", comment: "Point"), attributes: [
                .foregroundColor: AppColor.grey300.uiColor,
                .font: AppFont.reqular.s15()
            ])
        ]
        let string = NSMutableAttributedString()
        dataComponents.forEach(string.append)
        orderDataLabel.attributedText = string
    }

    // MARK: - Actions

    @objc func handleExpandClose() {
        self.delegate?.onCollapseMenuButtonDidPressed(section: section)
    }

    @objc func viewTapped() {
        self.delegate?.onCollapseMenuButtonDidPressed(section: section)
    }
}
