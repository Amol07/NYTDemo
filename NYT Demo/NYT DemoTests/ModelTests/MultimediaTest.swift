//
//  MultimediaTest.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import NYT_Demo

class MultimediaTest: XCTestCase {
    var multimedia: Multimedia!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.multimedia = Multimedia()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.multimedia = nil
    }
    
    func testMapping() {
        let jsonObject = [
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
            ] as [String : Any]
        let mapping = Mapping(json: jsonObject)
        self.multimedia.mapping(map: mapping)
        
        XCTAssertEqual(self.multimedia.caption, "Americans evacuated from the Diamond Princess cruise ship arrived early Monday at Lackland Air Force Base in San Antonio.")
        XCTAssertEqual(self.multimedia.copyright, "Edward A. Ornelas/Getty Images")
        XCTAssertEqual(self.multimedia.type, .image)
        
        if let mediaData = self.multimedia.mediaData {
            
            XCTAssertEqual(mediaData[0].url?.absoluteString, "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-thumbStandard-v4.jpg")
            XCTAssertEqual(mediaData[0].format, .standardThumbnail)
            
            XCTAssertEqual(mediaData[2].url?.absoluteString, "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-mediumThreeByTwo440-v4.jpg")
            XCTAssertEqual(mediaData[2].format, .mediumThreeByTwo440)
        }
    }
    
    func testMediaMappingWithUnknownMultimediaType() {
        let jsonObject = [
            "type":"something",
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
            ] as [String : Any]
        let mapping = Mapping(json: jsonObject)
        self.multimedia.mapping(map: mapping)
        
        XCTAssertEqual(self.multimedia.type, .unknown)
    }
    
    func testMediaMappingWithUnknownMultimediaTypeAndMediaFormatType() {
        let jsonObject = [
            "type":"something",
            "caption":"Americans evacuated from the Diamond Princess cruise ship arrived early Monday at Lackland Air Force Base in San Antonio.",
            "copyright":"Edward A. Ornelas/Getty Images",
            "media-metadata":[
                [
                    "url":"https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-thumbStandard-v4.jpg",
                    "format":"something"
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
            ] as [String : Any]
        let mapping = Mapping(json: jsonObject)
        self.multimedia.mapping(map: mapping)
    
        XCTAssertEqual(self.multimedia.type, .unknown)
        
        if let mediaData = self.multimedia.mediaData {
            XCTAssertEqual(mediaData[0].url?.absoluteString, "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-thumbStandard-v4.jpg")
            XCTAssertEqual(mediaData[0].format, .unknown)
            
            XCTAssertEqual(mediaData[2].url?.absoluteString, "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-mediumThreeByTwo440-v4.jpg")
            XCTAssertEqual(mediaData[2].format, .mediumThreeByTwo440)
        }
    }
}
