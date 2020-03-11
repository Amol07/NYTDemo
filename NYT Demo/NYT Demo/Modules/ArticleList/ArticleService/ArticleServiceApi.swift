//
//  ArticleServiceApi.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

protocol ArticleServiceApiProtocol {
    func request(pageIndex: UInt, offset: UInt, completion: @escaping (Response<[Article]>) -> Void)
}

class ArticleServiceApi {
    private let request: RequestServiceProtocol
    
    init(request: RequestServiceProtocol) {
        self.request = request
    }
}

// MARK: - ArticleServiceApiProtocol

extension ArticleServiceApi: ArticleServiceApiProtocol {
    func request(pageIndex: UInt, offset: UInt, completion: @escaping (Response<[Article]>) -> Void) {
        let responseCompletion: (Response<ArticleResponse>) -> Void = { response in
            switch response {
            case .success(let contentResponse):
                switch contentResponse.status {
                case .ok:
                    completion(.success(contentResponse.results))
                case .unknown:
                    completion(.failure(APIError.serverError.error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        let api: EndPoints = .getContents(pageIndex: pageIndex, offset: offset, path: Constant.APIConstant.viewedPath)
        self.request.object(from: api, completion: responseCompletion)
    }
}
