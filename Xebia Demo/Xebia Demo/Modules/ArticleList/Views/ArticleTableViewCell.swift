//
//  ArticleTableViewCell.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ArticleTableViewCellProtocol: ImageLoadable {
    var title: String { get }
    var date: String { get }
    var snippet: String { get }
    var article: Article { get }
}

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var snippetLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    private var viewModel: ArticleTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.width/2
    }

    func set(viewModel: ArticleTableViewCellProtocol) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.snippetLabel.text = viewModel.snippet
        self.dateLabel.text = !viewModel.date.isEmpty ? "🗓 \(viewModel.date)" : viewModel.date
        self.thumbnailImageView.image = nil
        viewModel.loadImage { [weak self] (id, response) in
            guard let strongSelf = self,
                strongSelf.viewModel?.id == id else { return }
            switch response {
            case .success(let image):
                strongSelf.thumbnailImageView.image = image;
            case .failure(let error):
                //TODO: Handle to show error here
                debugPrint(error.localizedDescription)
            }
        }
    }
}
