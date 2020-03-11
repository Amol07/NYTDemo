//
//  EndPointsTests.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import NYT_Demo

class EndPointsTests: XCTestCase {
    var endPoint: EndPoints!

    func testURLForGetArticlesAPI() {
        
        self.endPoint = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        XCTAssertTrue(self.endPoint.url.absoluteString.hasPrefix("https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?offset=0&api-key="))
        
        self.endPoint = .getContents(pageIndex: 1, offset: 20, path: "viewed")
        XCTAssertTrue(self.endPoint.url.absoluteString.hasPrefix("https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?offset=20&api-key="))
    }
    
    func testMethodForGetArticlesAPI() {
        self.endPoint = .getContents(pageIndex: 0, offset: 20, path: "viewed")
        XCTAssertEqual(self.endPoint.method, .get)
    }

}
