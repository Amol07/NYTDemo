//
//  RequestServiceTests.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import NYT_Demo

class RequestServiceTest: XCTestCase {
    
    var service: RequestService!
    var session: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        self.session = URLSessionMock()
        self.service = RequestService(session: self.session)
    }
    
    override func tearDown() {
        super.tearDown()
        self.session = nil
        self.service = nil
        super.tearDown()
    }
    
    func testObjectSuccess() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let json = [
            "object": ["string": "string1"],
            "array": [
                ["string": "string2"],
                ["string": "string3"],
                ["string": "string4"],
            ]] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<MappableObjectBMock>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNotNil(value)
                XCTAssertEqual(value.object?.string, "string1")
                XCTAssertEqual(value.array?.count, 3)
                if value.array?.count == 3 {
                    XCTAssertEqual(value.array?[0].string, "string2")
                    XCTAssertEqual(value.array?[1].string, "string3")
                    XCTAssertEqual(value.array?[2].string, "string4")
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        self.service.object(from: api, completion: completion)
        self.session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testObjectCannotMapping() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let json = [:] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<MappableObjectBMock>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNil(value.object)
                XCTAssertNil(value.array)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        self.service.object(from: api, completion: completion)
        self.session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testObjectCannotParseData() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let data = Data()
        let completion: (Response<MappableObjectBMock>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNil(value.object)
                XCTAssertNil(value.array)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        self.service.object(from: api, completion: completion)
        self.session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testObjectFailureWithError() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        let completion: (Response<MappableObjectBMock>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNil(value)
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
            }
            expectation.fulfill()
        }
        self.service.object(from: api, completion: completion)
        self.session.completion?(nil, nil, expectedError)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testArraySuccess() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let json = [[
            "object": ["string": "string1"],
            "array": [
                ["string": "string2"],
                ["string": "string3"],
                ["string": "string4"],
            ]]]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<[MappableObjectBMock]>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                if value.count == 1 {
                    XCTAssertEqual(value[0].object?.string, "string1")
                    XCTAssertEqual(value[0].array?.count, 3)
                    if value[0].array?.count == 3 {
                        XCTAssertEqual(value[0].array?[0].string, "string2")
                        XCTAssertEqual(value[0].array?[1].string, "string3")
                        XCTAssertEqual(value[0].array?[2].string, "string4")
                    }
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        self.service.array(from: api, completion: completion)
        self.session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testArrayCannotMapping() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let json = [[:]]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<[MappableObjectBMock]>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                if value.count == 1 {
                    XCTAssertNil(value[0].object)
                    XCTAssertNil(value[0].array)
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        self.service.array(from: api, completion: completion)
        self.session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testArrayCannotParseData() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let data = Data()
        let completion: (Response<[MappableObjectBMock]>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                if (value.count == 1) {
                    XCTAssertNil(value[0].object)
                    XCTAssertNil(value[0].array)
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        self.service.array(from: api, completion: completion)
        self.session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }

    func testArrayFailureWithError() {
        let api: EndPoints = .getContents(pageIndex: 0, offset: 0, path: "viewed")
        let expectation = XCTestExpectation(description: #function)
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        let completion: (Response<[MappableObjectBMock]>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNil(value)
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
            }
            expectation.fulfill()
        }
        self.service.array(from: api, completion: completion)
        self.self.session.completion?(nil, nil, expectedError)
        wait(for: [expectation], timeout: 0.1)
    }
}
