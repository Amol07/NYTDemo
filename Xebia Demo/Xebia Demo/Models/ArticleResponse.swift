//
//  ArticleResponse.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum ResponseStatus: String {
    case ok = "OK"
    case unknown = "unknown"
}

struct ArticleResponse {
    var status: ResponseStatus = .unknown
    var results: [Article] = []
}

// MARK: - Mappable

extension ArticleResponse: Mappable {
    mutating func mapping(map: Mapping) {
        self.status = map["status"] ?? .unknown
        self.results = map["results"] ?? []
    }
}
