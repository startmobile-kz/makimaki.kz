//
//  User.swift
//  maki-maki-ios
//
//  Created by Ravil on 04.07.2023.
//

import Foundation

struct User {
    let name: String
    let email: String
    let phone: String
    
    init(name: String = "Your Name", email: String = "your-email@example.com", phone: String = "1234567890") {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
