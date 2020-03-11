//
//  Mapper.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

struct Mapper<T: Mappable> {
    func map(json: Any) -> T? {
        guard let json = json as? [String: Any] else { return nil }
        let mapping = Mapping(json: json)
        var object = T()
        object.mapping(map: mapping)
        return object
    }
    
    func map(json: Any) -> [T]? {
        guard let jsonArray = json as? [Any] else { return nil }
        var objects: [T] = []
        for jsonObject in jsonArray {
            guard let jsonObject = jsonObject as? [String: Any] else { continue }
            let mapping = Mapping(json: jsonObject)
            var object = T()
            object.mapping(map: mapping)
            objects.append(object)
        }
        return objects
    }
}
