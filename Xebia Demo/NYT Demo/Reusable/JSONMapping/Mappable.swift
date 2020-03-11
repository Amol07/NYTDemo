//
//  Mappable.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

protocol Mappable {
    init()
    mutating func mapping(map: Mapping)
}
