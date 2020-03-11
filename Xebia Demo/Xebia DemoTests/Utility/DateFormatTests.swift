//
//  DateFormatTests.swift
//  Xebia DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import Xebia_Demo

class DateFormatTests: XCTestCase {
    var format: DateFormat!

    func testDateFromats() {
        self.format = .iso8601Date
        XCTAssertEqual(self.format.format, "yyyy-MM-dd")
        
        self.format = .date
        XCTAssertEqual(self.format.format, "dd/MM/yyyy")
        
        self.format = .custom(format: "EEE, MMM d, ''yy")
        XCTAssertEqual(self.format.format, "EEE, MMM d, ''yy")
    }
}
