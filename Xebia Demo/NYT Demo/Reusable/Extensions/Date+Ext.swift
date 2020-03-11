//
//  Date+Ext.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

extension Date {
    static let dateFormater = DateFormatter()
    var dateString: String {
        type(of: self).dateFormater.dateFormat = DateFormat.date.format
        return type(of: self).dateFormater.string(from: self)
    }
}
