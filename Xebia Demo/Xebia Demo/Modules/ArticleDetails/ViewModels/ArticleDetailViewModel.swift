//
//  ArticleDetailViewModel.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

protocol ArticleDetailItemViewModelProtocol {}

protocol ArticleDetailViewModelProtocol {
    var index: Int { get }
    var content: Article { get }
    var itemViewModels: [ArticleDetailItemViewModelProtocol] { get }
    func itemViewModel(at index: Int) -> ArticleDetailItemViewModelProtocol?
}

class ArticleDetailViewModel {
    let index: Int
    let content: Article
    let itemViewModels: [ArticleDetailItemViewModelProtocol]
    let downloadImageService: DownloadImageService
    
    init(content: Article, index: Int) {
        self.content = content
        self.index = index
        self.downloadImageService = DownloadImageService(session: URLSession.shared)
        var viewModels: [ArticleDetailItemViewModelProtocol] = [
            ArticleTitleTableCellViewModel(content: content),
            ArticleAggregateTableCellViewModel(content: content),
            ArticleAbstractTableCellViewModel(content: content),
            ]
        if let multimedia = content.multimedias?.last {
            viewModels.append(ArticleImageTableCellViewModel(multimedia: multimedia, downloadImageService: self.downloadImageService))
        }
        self.itemViewModels = viewModels
    }
}

// MARK: - ArticleDetailViewModelProtocol

extension ArticleDetailViewModel: ArticleDetailViewModelProtocol {
    func itemViewModel(at index: Int) -> ArticleDetailItemViewModelProtocol? {
        if index < self.itemViewModels.count {
            return self.itemViewModels[index]
        }
        return nil
    }
}
