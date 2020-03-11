//
//  ArticleServiceApiTests.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import NYT_Demo

class ArticleServiceApiTests: XCTestCase {
    var service: ArticleServiceApi!
    var request: RequestServiceMock<ArticleResponse>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.request = RequestServiceMock()
        self.service = ArticleServiceApi(request: self.request)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.request = nil
        self.service = nil
        super.tearDown()
    }
    
    func testRequestSuccess() {
        let successExpectation = expectation(description: #function + "success")
        let failureExpectation = expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedContent = Article()
        let contentResponse = ArticleResponse(status: .ok, results: [expectedContent])
        self.service.request(pageIndex: 0, offset: 0) { response in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                successExpectation.fulfill()
            case .failure:
                failureExpectation.fulfill()
            }
        }
        self.request.objectCompletion?(.success(contentResponse))
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestFailureCannotReachServer() {
        let successExpectation = expectation(description: #function + "success")
        successExpectation.isInverted = true
        let failureExpectation = expectation(description: #function + "failure")
        let contentResponse = ArticleResponse(status: .unknown, results: [])
        self.service.request(pageIndex: 0, offset: 0) { response in
            switch response {
            case .success:
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(APIError.serverError.error, error as NSError)
                failureExpectation.fulfill()
            }
        }
        self.request.objectCompletion?(.success(contentResponse))
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestFailure() {
        let successExpectation = expectation(description: #function + "success")
        successExpectation.isInverted = true
        let failureExpectation = expectation(description: #function + "failure")
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        self.service.request(pageIndex: 0, offset: 0) { response in
            switch response {
            case .success:
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
                failureExpectation.fulfill()
            }
        }
        self.request.objectCompletion?(.failure(expectedError))
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
}
