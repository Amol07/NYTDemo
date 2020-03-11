//
//  ArticleViewModel.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

protocol ArticleViewModelProtocol: Pageable {
    var onError: ((String) -> Void)?  { get set }
    var onReloadData: (() -> Void)?  { get set }
    var onMoreData: (([ArticleTableViewCellProtocol]) -> Void)? { get set }
    var contentViewModels: [ArticleTableViewCellProtocol] { get }
    func contentViewModel(at index: Int) -> ArticleTableViewCellProtocol?
    func append(contentViewModel: ArticleTableViewCellProtocol)
}

class ArticleViewModel {
    var onError: ((String) -> Void)?
    var onReloadData: (() -> Void)?
    var onMoreData: (([ArticleTableViewCellProtocol]) -> Void)?
    private(set) var isLoading: Bool
    private(set) var currentPageIndex: UInt
    private(set) var contentViewModels: [ArticleTableViewCellProtocol]
    private let articleService: ArticleServiceApiProtocol
    private var downloadImageService: DownloadImageServiceProtocol
    
    init(articleSerivce: ArticleServiceApiProtocol) {
        self.articleService = articleSerivce
        self.currentPageIndex = 0
        self.contentViewModels = []
        self.downloadImageService = DownloadImageService(session: URLSession.shared)
        self.isLoading = false
    }
}

// MARK: - HomeViewModel

extension ArticleViewModel: ArticleViewModelProtocol {
    func contentViewModel(at index: Int) -> ArticleTableViewCellProtocol? {
        if index < self.contentViewModels.count && index >= 0 {
            return self.contentViewModels[index]
        }
        return nil
    }
    
    func append(contentViewModel: ArticleTableViewCellProtocol) {
        self.contentViewModels.append(contentViewModel)
    }
}

// MARK: - Pageable

extension ArticleViewModel: Pageable {
    
    func refresh() {
        self.retrieveContents(pageIndex: 0)
    }
    
    func loadMore() {
        self.retrieveContents(pageIndex: self.currentPageIndex + 1)
    }
}

// MARK: - Privates

extension ArticleViewModel {
    private func retrieveContents(pageIndex: UInt) {
        guard !self.isLoading else { return } //Avoid making multiple requests at the same time.
        self.isLoading = true
        self.currentPageIndex = pageIndex
        self.articleService.request(pageIndex: self.currentPageIndex, offset: Constant.APIConstant.offset) { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            switch response {
            case .success(let contents):
                let contentViewModels = contents.map { ArticleTableCellViewModel(content: $0, downloadImageService: strongSelf.downloadImageService) }
                if strongSelf.currentPageIndex == Constant.APIConstant.defaultPageIndex {
                    strongSelf.contentViewModels = contentViewModels
                    DispatchQueue.main.async {
                        strongSelf.onReloadData?()
                    }
                } else if !contentViewModels.isEmpty {
                    DispatchQueue.main.async {
                        strongSelf.onMoreData?(contentViewModels)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.onError?(error.localizedDescription)
                }
            }
        }
    }
}

class ArticleViewModelFactory {
    static func create() -> ArticleViewModel {
        let session = URLSession.shared
        let request = RequestService(session: session)
        let articleSerivce = ArticleServiceApi(request: request)
        return ArticleViewModel(articleSerivce: articleSerivce)
    }
}
