//
//  SelectLocationViewController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 14.06.2023.
//

import UIKit
import SnapKit
import YandexMapsMobile

final class SelectLocationViewController: UIViewController {
    
    // MARK: - State
    
    private let addressService = AddressService()
    
    // MARK: - Map View UI
    
    private lazy var mapView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var yandexMap = YMKMapView()
    
    // MARK: - Address selection UI
    
    private lazy var addressSelectionView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.background.uiColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var selectLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Location"
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var yourLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR LOCATION"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s12()
        return label
    }()
    
    private lazy var locationTextField = OneLineTextField()
    
    private lazy var saveAsLabel: UILabel = {
        let label = UILabel()
        label.text = "Save As"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s12()
        return label
    }()
    
    private lazy var choiceLocationSegmentedController: UISegmentedControl = {
        let control = UISegmentedControl(
            first: "Home",
            second: "Work",
            third: "Other")
        control.layer.cornerRadius = 12
        control.layer.masksToBounds = true
        control.clipsToBounds = true
        return control
    }()
        
    private lazy var saveAddressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE ADDRESS", for: .normal)
        button.tintColor = AppColor.heading.uiColor
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(saveAddressButtonDidPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupYandexMap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cornerRadius()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [mapView, addressSelectionView,
         selectLocationLabel, yourLocationLabel, locationTextField,
         saveAsLabel, choiceLocationSegmentedController, saveAddressButton].forEach {
            view.addSubview($0)
        }
        
         mapView.addSubview(yandexMap)
    }
    
    private func cornerRadius() {
        addressSelectionView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    // MARK: - Setup Yandex Map
    
    private func setupYandexMap() {
        yandexMap.mapWindow.map.move(
                with: YMKCameraPosition.init(
                    target: YMKPoint(
                        latitude: 55.751574,
                        longitude: 37.573856
                    ),
                    zoom: 15,
                    azimuth: 0,
                    tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)
    }
    
    // MARK: - Setup Constrainrs
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addressSelectionView.snp.top).offset(20)
        }
        
        addressSelectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(434)
        }
        
        selectLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(addressSelectionView.snp.top).offset(27)
            make.leading.equalTo(addressSelectionView.snp.leading).offset(16)
        }
        
        yourLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(selectLocationLabel.snp.bottom).offset(26)
            make.leading.equalTo(addressSelectionView.snp.leading).offset(16)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(yourLocationLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        saveAsLabel.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(45)
            make.leading.equalTo(addressSelectionView.snp.leading).offset(16)
        }
        
        choiceLocationSegmentedController.snp.makeConstraints { make in
            make.top.equalTo(saveAsLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        saveAddressButton.snp.makeConstraints { make in
            make.top.equalTo(choiceLocationSegmentedController.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
        }
    }
    
    // MARK: - Actions
    
    @objc private func saveAddressButtonDidPressed() {
        guard let text = locationTextField.text  else {
            return
        }
      
        let newAddress = Address(id: UUID(),
                                 street: text,
                                 latitude: 43.297601,
                                 longitude: 76.974137,
                                 house: "45",
                                 flat: "44",
                                 type: choiceLocationSegmentedController.selectedSegmentIndex
        )
        
        addressService.saveAddress(address: newAddress)
        self.navigationController?.popToRootViewController(animated: true)
    }

}
