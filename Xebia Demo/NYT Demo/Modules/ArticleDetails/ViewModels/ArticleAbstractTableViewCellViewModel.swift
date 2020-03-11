//
//  ArticleAbstractTableCellViewModel.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ArticleAbstractTableCellViewModel {
    private let content: Article
    
    init(content: Article) {
        self.content = content
    }
}

// MARK: - ArticleAbstractTableViewCellProtocol

extension ArticleAbstractTableCellViewModel: ArticleAbstractTableViewCellProtocol {
    var abstract: String {
        return self.content.abstract ?? ""
    }
}
