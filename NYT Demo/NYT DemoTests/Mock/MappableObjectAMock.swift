//
//  MappableObjectAMock.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

@testable import NYT_Demo

struct MappableObjectAMock: Mappable {
    var string: String?
    
    mutating func mapping(map: Mapping) {
        self.string = map["string"]
    }
}
