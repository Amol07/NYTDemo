//
//  RequestService.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

public enum Response<Value> {
    case success(Value)
    case failure(Error)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol RequestServiceProtocol {
    func object<T: Mappable>(from api: EndPoints, completion: @escaping (Response<T>) -> Void)
    func array<T: Mappable>(from api: EndPoints, completion: @escaping (Response<[T]>) -> Void)
}

class RequestService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
}

extension RequestService: RequestServiceProtocol {
    func object<T: Mappable>(from api: EndPoints, completion: @escaping (Response<T>) -> Void) {
        request(api: api) { (response) in
            switch response {
            case .success(let json):
                if let object: T = Mapper<T>().map(json: json) {
                    completion(.success(object))
                } else {
                    completion(.failure(APIError.mapping.error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func array<T: Mappable>(from api: EndPoints, completion: @escaping (Response<[T]>) -> Void) {
        request(api: api) { (response) in
            switch response {
            case .success(let json):
                if let array: [T] = Mapper<T>().map(json: json) {
                    completion(.success(array))
                } else {
                    completion(.failure(APIError.mapping.error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Privates

extension RequestService {
    private func request(api: EndPoints, completion: @escaping (Response<Any>) -> Void) {
        var request = URLRequest(url: api.url)
        request.httpMethod = api.method.rawValue
        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
            do {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    let json = try JSONSerialization.jsonObject(with: data)
                    completion(.success(json))
                } else {
                    completion(.failure(APIError.unexpected.error))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
