//
//  ArticlesViewControllerUITest.swift
//  NYT DemoUITests
//
//  Created by Amol Prakash on 09/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest

class ArticlesViewControllerUITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testGoToArticleDetail() {
        sleep(2) //Waiting for network
        self.app.tables.cells.firstMatch.swipeDown()
        self.app.tables.children(matching: .cell).element(boundBy: 0).tap()
        self.app.tables.cells.firstMatch.swipeUp()
        self.app.tables.cells.firstMatch.swipeDown()
        self.app.navigationBars.buttons.firstMatch.tap()
    }
}
