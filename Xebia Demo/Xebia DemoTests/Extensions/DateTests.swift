//
//  DateTests.swift
//  Xebia DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import Xebia_Demo

class DateTests: XCTestCase {
    var date: Date!

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.date = nil
    }

    func testDateString() {
        var component = DateComponents()
        component.year = 2018
        component.month = 5
        component.day = 12
        self.date = Calendar.current.date(from: component)
        let dateString = self.date.dateString
        XCTAssertEqual(dateString, "12/05/2018")
    }
}
