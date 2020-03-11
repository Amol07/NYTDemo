//
//  ArticleTests.swift
//  Xebia DemoTests
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import Xebia_Demo

class ArticleTests: XCTestCase {
    var article: Article!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.article = Article()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.article = nil
    }
    
    func testMapping() {
        let jsonObject = [
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
            ] as [String : Any]
        let mapping = Mapping(json: jsonObject)
        self.article.mapping(map: mapping)
        XCTAssertEqual(self.article.title, "Cruise Ship Passengers, Some Infected, Flown Back to U.S.")
        XCTAssertEqual(self.article.abstract, "As passengers were evacuated from one ship in Japan, health officials scrambled to test people on another, in Cambodia.")
        XCTAssertEqual(self.article.byline, "")
        XCTAssertEqual(self.article.source, "The New York Times")
        XCTAssertNotNil(self.article.url)
        if let absoluteString = self.article.url?.absoluteString {
            XCTAssertEqual(absoluteString, "https://www.nytimes.com/2020/02/17/world/asia/china-coronavirus.html")
        }
        XCTAssertNotNil(self.article.date)
        XCTAssertNotNil(self.article.multimedias)
        if let multimedias = self.article.multimedias {
            XCTAssertEqual(multimedias.count, 1)
            XCTAssertEqual(multimedias[0].type, .image)
            XCTAssertEqual(multimedias[0].copyright, "Edward A. Ornelas/Getty Images")
            
            XCTAssertEqual(multimedias[0].mediaData?[0].url?.absoluteString, "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-thumbStandard-v4.jpg")
            XCTAssertEqual(multimedias[0].mediaData?[0].format, .standardThumbnail)
            
            XCTAssertEqual(multimedias[0].mediaData?[2].url?.absoluteString, "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-mediumThreeByTwo440-v4.jpg")
            XCTAssertEqual(multimedias[0].mediaData?[2].format, .mediumThreeByTwo440)
        }
    }
}
