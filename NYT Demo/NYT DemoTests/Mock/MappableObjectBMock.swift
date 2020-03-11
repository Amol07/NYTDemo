//
//  MappableObjectBMock.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

@testable import NYT_Demo

struct MappableObjectBMock: Mappable {
    var object: MappableObjectAMock?
    var array: [MappableObjectAMock]?
    
    mutating func mapping(map: Mapping) {
        self.object = map["object"]
        self.array = map["array"]
    }
}
