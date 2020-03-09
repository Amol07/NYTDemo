//
//  DownloadImageService.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
import UIKit

protocol DownloadImageServiceProtocol {
    func download(url: URL, completion: @escaping (Response<UIImage>) -> Void)
}

class DownloadImageService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
}

// MARK: - DownloadImageServiceProtocol

extension DownloadImageService: DownloadImageServiceProtocol {
    func download(url: URL, completion: @escaping (Response<UIImage>) -> Void) {
        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(APIError.unexpected.error))
            }
        }.resume()
    }
}
