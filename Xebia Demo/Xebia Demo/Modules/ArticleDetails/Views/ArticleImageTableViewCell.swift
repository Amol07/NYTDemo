//
//  ArticleImageTableViewCell.swift
//  Xebia Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ArticleImageTableViewCellProtocol: ImageLoadable, ArticleDetailItemViewModelProtocol {
    var caption: String { get }
}

class ArticleImageTableViewCell: UITableViewCell {
    @IBOutlet private weak var multimediaImageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    
    private var viewModel: ArticleImageTableViewCellProtocol?
    
    func set(viewModel: ArticleImageTableViewCellProtocol) {
        self.viewModel = viewModel
        self.captionLabel.text = viewModel.caption
        self.multimediaImageView.image = nil
        viewModel.loadImage { [weak self] (id, response) in
            guard let strongSelf = self,
                strongSelf.viewModel?.id == id else { return }
            switch response {
            case .success(let image):
                strongSelf.multimediaImageView.image = image;
            case .failure(let error):
                //TODO: Handle to show error here
                debugPrint(error.localizedDescription)
            }
        }
    }
}
