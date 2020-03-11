//
//  RequestServiceMock.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

@testable import NYT_Demo

class RequestServiceMock<TMock: Mappable>: RequestServiceProtocol {
    var objectCompletion: ((Response<TMock>) -> Void)?
    var arrayCompletion: ((Response<[TMock]?>) -> Void)?
    
    func object<T>(from api: EndPoints, completion: @escaping (Response<T>) -> Void) {
        self.objectCompletion = { response in
            switch response {
            case .success(let value):
                completion(.success(value as! T))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func array<T>(from api: EndPoints, completion: @escaping (Response<[T]>) -> Void) {
        self.arrayCompletion = { response in
            switch response {
            case .success(let value):
                completion(.success(value as! [T]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
