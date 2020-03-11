//
//  ArticleResponseTest.swift
//  Xebia DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import Xebia_Demo

class ArticleResponseTest: XCTestCase {
    var respone: ArticleResponse!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.respone = ArticleResponse()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.respone = nil
    }
    
    func testResponseMapping() {
        let jsonObject = [
            "status": "OK",
            "results": [[
                "url":"https://www.nytimes.com/2020/02/17/world/asia/china-coronavirus.html",
                "byline":"",
                "title":"Cruise Ship Passengers, Some Infected, Flown Back to U.S.",
                "abstract":"As passengers were evacuated from one ship in Japan, health officials scrambled to test people on another, in Cambodia.",
                "published_date":"2020-02-17",
                "source":"The New York Times",
                "media":[
                    [
                        "type":"image",
                        "caption":"Americans evacuated from the Diamond Princess cruise ship arrived early Monday at Lackland Air Force Base in San Antonio.",
                        "copyright":"Edward A. Ornelas/Getty Images",
                        "media-metadata":[
                            [
                                "url":"https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-thumbStandard-v4.jpg",
                                "format":"Standard Thumbnail"
                            ],
                            [
                                "url":"https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-mediumThreeByTwo210-v4.jpg",
                                "format":"mediumThreeByTwo210"
                            ],
                            [
                                "url":"https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-mediumThreeByTwo440-v4.jpg",
                                "format":"mediumThreeByTwo440"
                            ]
                        ]
                    ]
                ]
            ]]
            ] as [String : Any]
        
        let mapping = Mapping(json: jsonObject)
        self.respone.mapping(map: mapping)
        
        XCTAssertEqual(self.respone.status, .ok)
        XCTAssertEqual(self.respone.results.count, 1)
        if self.respone.results.count == 1 {
            XCTAssertEqual(self.respone.results[0].title, "Cruise Ship Passengers, Some Infected, Flown Back to U.S.")
            XCTAssertEqual(self.respone.results[0].abstract, "As passengers were evacuated from one ship in Japan, health officials scrambled to test people on another, in Cambodia.")
        }
    }
    
    func testResponseMappingWithZeroResultCount() {
        let jsonObject = [
            "status": "OK",
            "results": []
            ] as [String : Any]
        
        let mapping = Mapping(json: jsonObject)
        self.respone.mapping(map: mapping)
        
        XCTAssertEqual(self.respone.status, .ok)
        XCTAssertEqual(self.respone.results.count, 0)
    }
    
    func testResponseMappingWithZeroResultsAndUnknownStatus() {
        let jsonObject = [
            "status": "Something",
            "results": "<Null>"
            ] as [String : Any]
        
        let mapping = Mapping(json: jsonObject)
        self.respone.mapping(map: mapping)
        
        XCTAssertEqual(self.respone.status, .unknown)
        XCTAssertEqual(self.respone.results.count, 0)
    }
}
