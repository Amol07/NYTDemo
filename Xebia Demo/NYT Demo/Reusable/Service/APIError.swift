//
//  APIError.swift
//  NYT Demo
//
//  Created by Amol Prakash on 09/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum APIError: Int {
    case unexpected = -1
    case mapping = -2
    case serverError = -3
    
    var code: Int {
        return self.rawValue
    }
    
    var description: String {
        switch self {
        case .unexpected:
            return NSLocalizedString("Unexpected error", comment: "")
        case .mapping:
            return NSLocalizedString("Cannot mapping object", comment: "")
        case .serverError:
            return NSLocalizedString("Cannot connect to server", comment: "")
        }
    }
    
    var error: NSError {
        return NSError(domain: "com.amolprakash.nyt.error", code: code, userInfo: [NSLocalizedDescriptionKey: self.description])
    }
}
