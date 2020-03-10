//
//  ArticleAbstractTableViewCell.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ArticleAbstractTableViewCellProtocol: ArticleDetailItemViewModelProtocol {
    var abstract: String { get }
}

class ArticleAbstractTableViewCell: UITableViewCell {
    @IBOutlet private weak var abstractLabel: UILabel!
    
    func set(viewModel: ArticleAbstractTableViewCellProtocol) {
        self.abstractLabel.text = viewModel.abstract
    }
}
