//
//  Protocols.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ImageLoadable {
    var id: String { get }
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void)
}

protocol Pageable {
    var isLoading: Bool { get }
    var currentPageIndex: UInt { get }
    func refresh()
    func loadMore()
}
