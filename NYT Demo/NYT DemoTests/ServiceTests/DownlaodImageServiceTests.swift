//
//  DownlaodImageServiceTests.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
import UIKit
@testable import NYT_Demo

class DownlaodImageServiceTests: XCTestCase {
    var downloadService: DownloadImageService!
    var session: URLSessionMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.session = URLSessionMock()
        self.downloadService = DownloadImageService(session: self.session)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.session = nil
        self.downloadService = nil
        super.tearDown()
    }
    
    
    func testDownloadSuccess() {
        let image = UIImage(named: "test1", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let data = image.pngData()

        let expectation = XCTestExpectation(description: #function)
        self.downloadService.download(url: URL(string: "https://static01.nyt.com/images/2018/05/12/us/12familyseparation/12familyseparation-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNotNil(image)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        self.session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDownloadFailure() {
        let expectation = XCTestExpectation(description: #function)
        self.downloadService.download(url: URL(string: "https://static01.nyt.com/images/2018/05/12/us/12familyseparation-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNil(image)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        self.session.completion?(nil, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
}
