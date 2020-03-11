//
//  Mapping.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

struct Mapping {
    private var json: [String: Any]
    
    init(json: [String: Any]) {
        self.json = json
    }
    
    //Convert object to a string
    subscript(key: String) -> String? {
        return self.targetJSON(for: key) as? String
    }

    //Convert object to an URL
    subscript(key: String) -> URL? {
        guard let string = self.targetJSON(for: key) as? String else { return nil }
        return URL(string: string)
    }
    
    //Convert object to a date
    subscript(key: String, dateFormat: DateFormat) -> Date? {
        guard let string = self.targetJSON(for: key) as? String else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.format
        return formatter.date(from: string)
    }
    
    //Convert object to a mappable object support multiple levels access.
    subscript<T: Mappable>(key: String) -> T? {
        guard let value = self.targetJSON(for: key) else { return nil }
        return Mapper<T>().map(json: value)
    }
    
    //Convert object to an array of mappable objects
    subscript<T: Mappable>(key: String) -> [T]? {
        guard let value = self.targetJSON(for: key) else { return nil }
        return Mapper<T>().map(json: value)
    }
    
    //Convert object to an enum
    subscript<T: RawRepresentable>(key: String) -> T? {
        guard let rawValue = self.targetJSON(for: key) as? T.RawValue else { return nil }
        return T(rawValue: rawValue)
    }
}

// MARK: Privates

extension Mapping {
    /* Get multiple levels value from a key which is separated by `.`
     * E.g: { "keyLevel1": { "keyLevel2" : { "keyLevel3": "valueLevel3" } } }
     * With key: "keyLevel1.keyLevel2.keyLevel3" the returning is: "valueLevel3"
     */
    private func targetJSON(for key: String) -> Any? {
        var value: Any = self.json
        for levelKey in keys(from: key) {
            guard let valueJSON = value as? [String: Any],
                let levelValue = valueJSON[levelKey] else { return nil }
            value = levelValue
        }
        return value
    }
    
    private func keys(from key: String) -> [String] {
        //Get multiple levels key separate by `.`
        return key.components(separatedBy: ".")
    }
}
