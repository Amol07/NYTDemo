//
//  Multimedia.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum MultimediaFormat: String {
    case standardThumbnail = "Standard Thumbnail"
    case normal = "Normal"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case unknown = "unknown"
}

enum MultimediaType: String {
    case image = "image"
    case unknown = "unknown"
}

struct Multimedia {
    var type: MultimediaType = .unknown
    var caption: String?
    var copyright: String?
    var mediaData: [MediaData]?
}

// MARK: - Mappable
extension Multimedia: Mappable {
    mutating func mapping(map: Mapping) {
        self.type = map["type"] ?? .unknown
        self.caption = map["caption"]
        self.copyright = map["copyright"]
        self.mediaData = map["media-metadata"]
    }
}

struct MediaData {
    var url: URL?
    var format: MultimediaFormat = .unknown
}

// MARK: - Mappable
extension MediaData: Mappable {
    mutating func mapping(map: Mapping) {
        self.format = map["format"] ?? .unknown
        self.url = map["url"]
    }
}
