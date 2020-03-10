//
//  ArticleAggregateTableViewCell.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ArticleAggregateTableViewCellProtocol: ArticleDetailItemViewModelProtocol {
    var date: String { get }
    var source: String { get }
    var byline: String { get }
}

class ArticleAggregateTableViewCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var bylineLabel: UILabel!
    
    func set(viewModel: ArticleAggregateTableViewCellProtocol) {
        self.dateLabel.text = viewModel.date
        self.bylineLabel.text = viewModel.byline
        self.sourceLabel.text = viewModel.source
    }
}
