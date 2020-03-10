//
//  ArticleDetailViewController.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
     
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.register(type: ArticleTitleTableViewCell.self)
            self.tableView.register(type: ArticleAggregateTableViewCell.self)
            self.tableView.register(type: ArticleAbstractTableViewCell.self)
            self.tableView.register(type: ArticleImageTableViewCell.self)
            self.tableView.dataSource = self
            self.tableView.estimatedRowHeight = 100
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.separatorStyle = .none
        }
    }
    var viewModel: ArticleDetailViewModelProtocol?
}

// MARK: - UITableViewDataSource

extension ArticleDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel else { return UITableViewCell() }
        let itemViewModel = viewModel.itemViewModel(at: indexPath.row)
        if let itemViewModel = itemViewModel as? ArticleTitleTableViewCellProtocol {
            let cell = tableView.dequeueReusableCell(type: ArticleTitleTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleAggregateTableViewCellProtocol {
            let cell = tableView.dequeueReusableCell(type: ArticleAggregateTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleAbstractTableViewCellProtocol {
            let cell = tableView.dequeueReusableCell(type: ArticleAbstractTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        if let itemViewModel = itemViewModel as? ArticleImageTableViewCellProtocol {
            let cell = tableView.dequeueReusableCell(type: ArticleImageTableViewCell.self, for: indexPath)
            cell.set(viewModel: itemViewModel)
            return cell
        }
        return UITableViewCell()
    }
}
