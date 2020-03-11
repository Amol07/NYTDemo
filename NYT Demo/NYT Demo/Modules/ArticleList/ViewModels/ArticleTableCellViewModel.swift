//
//  ArticleTableCellViewModel.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ArticleTableCellViewModel {
    internal let article: Article
    private let downloadImageService: DownloadImageServiceProtocol
    
    init(content: Article, downloadImageService: DownloadImageServiceProtocol) {
        self.article = content
        self.downloadImageService = downloadImageService
    }
}

// MARK: - ContentTableViewCellProtocol

extension ArticleTableCellViewModel: ArticleTableViewCellProtocol {
    var id: String {
        return self.article.url?.absoluteString ?? ""
    }
    
    var title: String {
        return self.article.title ?? ""
    }
    
    var date: String {
        return self.article.date?.dateString ?? ""
    }
    
    var snippet: String {
        return self.article.abstract ?? ""
    }
    
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        let url = self.article.multimedias?.last?.mediaData?.first?.url
        guard let imageURL = url else { return }
        self.downloadImageService.download(url: imageURL) { [weak self] (response) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                switch response {
                case .success(let image):
                    completion(strongSelf.id, .success(image))
                case .failure(let error):
                    completion(strongSelf.id, .failure(error))
                }
            }
        }
    }
}
