//
//  DownloadImageServiceMock.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit
@testable import NYT_Demo

class DownloadImageServiceMock: DownloadImageServiceProtocol {
    var completion: ((Response<UIImage>) -> Void)?
    
    func download(url: URL, completion: @escaping (Response<UIImage>) -> Void) {
        self.completion = completion
    }
}
