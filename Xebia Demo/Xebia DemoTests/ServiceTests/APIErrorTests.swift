//
//  APIErrorTests.swift
//  Xebia DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import Xebia_Demo

class APIErrorTests: XCTestCase {
    var error: APIError!

    func testError() {
        self.error = .unexpected
        XCTAssertEqual(self.error.code, -1)
        XCTAssertEqual(self.error.description, "Unexpected error")
        XCTAssertEqual(self.error.error.code, -1)
        XCTAssertEqual(self.error.error.localizedDescription, "Unexpected error")
        
        self.error = .mapping
        XCTAssertEqual(self.error.code, -2)
        XCTAssertEqual(self.error.description, "Cannot mapping object")
        XCTAssertEqual(self.error.error.code, -2)
        XCTAssertEqual(self.error.error.localizedDescription, "Cannot mapping object")
        
        
        self.error = .serverError
        XCTAssertEqual(self.error.code, -3)
        XCTAssertEqual(self.error.description, "Cannot connect to server")
        XCTAssertEqual(self.error.error.code, -3)
        XCTAssertEqual(self.error.error.localizedDescription, "Cannot connect to server")
    }
}
