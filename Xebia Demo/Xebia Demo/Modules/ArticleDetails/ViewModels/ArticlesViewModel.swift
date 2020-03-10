//
//  ArticlesViewModel.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

protocol ArticlesViewModelProtocol {
    var currentIndex: Int { get }
    var detailViewModels: [ArticleDetailViewModel] { get }
    func detailViewModel(at index: Int) -> ArticleDetailViewModel?
}

class ArticlesViewModel {
    let currentIndex: Int
    let detailViewModels: [ArticleDetailViewModel]
    
    init(contents: [Article], currentIndex: Int) {
        self.currentIndex = currentIndex
        var viewModels: [ArticleDetailViewModel] = []
        for (index, content) in contents.enumerated() {
            let detailViewModel = ArticleDetailViewModel(content: content, index: index)
            viewModels.append(detailViewModel)
        }
        self.detailViewModels = viewModels
    }
}

// MARK: - ArticlesViewModelProtocol

extension ArticlesViewModel: ArticlesViewModelProtocol {
    func detailViewModel(at index: Int) -> ArticleDetailViewModel? {
        if index < self.detailViewModels.count && index >= 0 {
            return self.detailViewModels[index]
        }
        return nil
    }
}
