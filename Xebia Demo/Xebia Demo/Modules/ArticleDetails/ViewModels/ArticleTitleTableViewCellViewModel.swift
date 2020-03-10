//
//  ArticleTitleTableViewCellViewModel.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

class ArticleTitleTableCellViewModel {
    private let content: Article
    
    init(content: Article) {
        self.content = content
    }
}

// MARK: - ArticleTitleTableViewCellProtocol

extension ArticleTitleTableCellViewModel: ArticleTitleTableViewCellProtocol {
    var title: String {
        return self.content.title ?? ""
    }
}
