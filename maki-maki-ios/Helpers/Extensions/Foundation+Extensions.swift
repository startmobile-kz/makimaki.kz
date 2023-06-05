//
//  Foundation+Extensions.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 04.06.2023.
//

import Foundation

extension NSError {

    var isConnectivityError: Bool {
        
        guard domain == NSURLErrorDomain else { return false }

        let connectivityErrors = [
            NSURLErrorTimedOut,
            NSURLErrorNotConnectedToInternet,
            NSURLErrorNetworkConnectionLost,
            NSURLErrorCannotConnectToHost
        ]

        return connectivityErrors.contains(code)
    }
}
