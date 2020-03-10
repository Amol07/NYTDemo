//
//  ArticleTitleTableViewCell.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ArticleTitleTableViewCellProtocol: ArticleDetailItemViewModelProtocol {
    var title: String { get }
}

class ArticleTitleTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func set(viewModel: ArticleTitleTableViewCellProtocol) {
        self.titleLabel.text = viewModel.title
    }
}
