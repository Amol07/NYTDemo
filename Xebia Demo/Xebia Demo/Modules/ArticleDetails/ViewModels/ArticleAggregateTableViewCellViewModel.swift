//
//  ArticleAggregateTableCellViewModel.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

class ArticleAggregateTableCellViewModel {
    private let content: Article
    
    init(content: Article) {
        self.content = content
    }
}

// MARK: - ArticleAggregateTableViewCellProtocol

extension ArticleAggregateTableCellViewModel: ArticleAggregateTableViewCellProtocol {
    var date: String {
        return self.content.date?.dateString ?? ""
    }
    
    var byline: String {
        return self.content.byline ?? ""
    }
    
    var source: String {
        return self.content.source ?? ""
    }
}

