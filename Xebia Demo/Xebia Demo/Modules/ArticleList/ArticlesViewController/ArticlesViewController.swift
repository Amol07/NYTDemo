//
//  ArticlesViewController.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.register(type: ArticleTableViewCell.self)
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    private var refreshControl: UIRefreshControl!
    
    var viewModel: ArticleViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.ArticlesViewController.ToArticleDetailsIdentifier,
            let articlesVC = segue.destination as? ArticleDetailViewController,
            let model = sender as? ArticleTableViewCellProtocol {
            let articlesVm = ArticleDetailViewModel(content: model.article)
            articlesVC.viewModel = articlesVm
        }
    }
}

// MARK: - UITableViewDataSource

extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.contentViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(type: ArticleTableViewCell.self, for: indexPath)
        if let content = viewModel.contentViewModel(at: indexPath.item) {
            cell.set(viewModel: content)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ArticlesViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            self.viewModel?.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else { return }
        if let content = viewModel.contentViewModel(at: indexPath.item) {
            self.performSegue(withIdentifier: Constant.ArticlesViewController.ToArticleDetailsIdentifier, sender: content)
        }
    }
}

// MARK: - Users Interactions

extension ArticlesViewController {
    
    @objc func refreshControlValueChanged() {
        self.viewModel?.refresh()
    }
}

// MARK: - Privates

extension ArticlesViewController {
   
    private func setupViews() {
        title = NSLocalizedString("NY Times Most Popular", comment: "")
        self.refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.refreshControl.addTarget(self, action: #selector(self.refreshControlValueChanged), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        self.initializeBarButtons()
    }
    
    private func initializeBarButtons() {
        // Initialize BarButton Items
        let leftButton = UIBarButtonItem(image: UIImage(named: "drawer_menu"), style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftButton
        let threeDotImage = UIImage(named: "menu")
        let customButton = UIBarButtonItem(image: threeDotImage, style: .plain, target: nil, action: nil)
        let searchImage = UIImage(named: "search")
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(self.didTapSearchButtonItem(_:)))
        self.navigationItem.rightBarButtonItems = [customButton, searchButton]
    }
    
    @objc func didTapSearchButtonItem(_ sender: Any) {
        
    }
    
    private func setupViewModel() {
        
        self.viewModel?.onReloadData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.refreshControl.endRefreshing()
            strongSelf.loadingView.stopAnimating()
            strongSelf.tableView.reloadData()
        }
        
        self.viewModel?.onMoreData = { [weak self] contents in
            guard let strongSelf = self, let viewModel = self?.viewModel else { return }
            strongSelf.tableView.performBatchUpdates({
                for content in contents {
                    viewModel.append(contentViewModel: content)
                    let indexPath = IndexPath(item: viewModel.contentViewModels.count - 1, section: 0)
                    strongSelf.tableView.insertRows(at: [indexPath], with: .none)
                }
            })
        }
        
        self.viewModel?.onError = { [weak self] errorMessage in
            guard let strongSelf = self else { return }
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorMessage, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            strongSelf.present(alertController, animated: true, completion: nil)
            strongSelf.refreshControl.endRefreshing()
            strongSelf.loadingView.stopAnimating()
        }
        self.viewModel?.refresh()
    }
}

extension Constant {
    struct ArticlesViewController {
        static let ToArticleDetailsIdentifier = "ToArticleDetail"
    }
}
