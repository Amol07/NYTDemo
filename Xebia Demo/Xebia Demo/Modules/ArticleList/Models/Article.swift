//
//  Article.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

struct Article {
    var title: String?
    var abstract: String?
    var url: URL?
    var date: Date?
    var multimedias: [Multimedia]?
    var byline: String?
    var source: String?
}

// MARK: - Mappable
extension Article: Mappable {
    mutating func mapping(map: Mapping) {
        self.title = map["title"]
        self.abstract = map["abstract"]
        self.url = map["url"]
        self.date = map["published_date", .iso8601Date]
        self.multimedias = map["media"]
        self.byline = map["byline"]
        self.source = map["source"]
    }
}
