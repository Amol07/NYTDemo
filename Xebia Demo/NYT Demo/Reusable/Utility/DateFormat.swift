//
//  DateFormat.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum DateFormat {
    case date
    case iso8601Date
    case custom(format: String)
    
    var format: String {
        switch self {
        case .iso8601Date:
            return "yyyy-MM-dd"
        case .date:
            return "dd/MM/yyyy"
        case .custom(let format):
            return format
        }
    }
}
