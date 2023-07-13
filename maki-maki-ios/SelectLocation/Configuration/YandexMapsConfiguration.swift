//
//  YandexMapsConfiguration.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 04.07.2023.
//

import Foundation
import YandexMapsMobile

class YandexMapsConfiguration {
    static func configure() {
        YMKMapKit.setApiKey("08250651-9f7f-46bd-ada3-472616554102")
        YMKMapKit.sharedInstance()
    }
}
