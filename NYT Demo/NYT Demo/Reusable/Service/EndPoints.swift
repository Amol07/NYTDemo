//
//  EndPoints.swift
//  NYT Demo
//
//  Created by Amol Prakash on 09/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum EndPoints {
    case getContents(pageIndex: UInt, offset: UInt, path: String)
    
    var method: HTTPMethod {
        switch self {
        case .getContents:
            return .get
        }
    }
    
    var url: URL {
        var component = URLComponents()
        component.scheme = Constant.APIConstant.scheme
        component.host = Constant.APIConstant.host
        component.path = self.path
        component.queryItems = self.queryItems + [URLQueryItem(name: "api-key", value: Constant.APIConstant.apiKey)]
        return component.url! //Force unwrapping to make sure URL never nil
    }
}

// MARK: - Privates

extension EndPoints {
    private var path: String {
        switch self {
        case .getContents(_, _, let path):
            return "/svc/mostpopular/v2/\(path)/30.json"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getContents(let pageIndex, let offset, _):
            return [URLQueryItem(name: "offset", value: "\(pageIndex * offset)")]
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
