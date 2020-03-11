//
//  URLSessionMock.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
@testable import NYT_Demo

class URLSessionDataTaskMock: URLSessionDataTask {
    override func resume() {
        //Overriding method
    }
}

class URLSessionMock: URLSessionProtocol {
    
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.completion = completionHandler
        return URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
    }
}
