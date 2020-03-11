//
//  ArticleServiceApiMock.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

@testable import NYT_Demo

class ArticleServiceApiMock: ArticleServiceApiProtocol {
    var pageIndex: UInt = 0
    var offset: UInt = 0
    var completion: ((Response<[Article]>) -> Void)?
 
    func request(pageIndex: UInt, offset: UInt, completion: @escaping (Response<[Article]>) -> Void) {
        self.offset = offset
        self.pageIndex = pageIndex
        self.completion = completion
    }
    
}
