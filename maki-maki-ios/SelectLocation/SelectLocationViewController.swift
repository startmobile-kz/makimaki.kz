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
    
    // MARK: - UI
    private lazy var yandexMap = YMKMapView()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        setupViews()
        setupConstraints()
        setupConfigureSheet()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(yandexMap)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        yandexMap.snp.makeConstraints { make in
              make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Configure Sheet
    private func setupConfigureSheet() {
        let viewController = BottomSheetViewController()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        
//        navVC.isModalInPresentation = true
//        if let sheet = navVC.sheetPresentationController {
//            sheet.detents = [.custom(resolver: { context in
//                return 378
//            }), .medium()]
//            sheet.largestUndimmedDetentIdentifier = .medium
//        }
        
        navigationViewController.isModalInPresentation = true
        if #available(iOS 15.0, *) {
            if let sheet = navigationViewController.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.detents = [.custom(resolver: { _ in
                        return 378
                    }), .medium()]
                } else {
                    // Fallback on earlier versions
                }
                sheet.largestUndimmedDetentIdentifier = .medium
            }
        } else {
            // Fallback on earlier versions
        }

        navigationController?.present(navigationViewController, animated: true)
    }
}
