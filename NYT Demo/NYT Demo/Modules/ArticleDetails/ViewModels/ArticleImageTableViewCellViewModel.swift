//
//  ArticleImageTableViewCellViewModel.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ArticleImageTableCellViewModel {
    private let multimedia: Multimedia
    private let downloadImageService: DownloadImageServiceProtocol
    
    init(multimedia: Multimedia, downloadImageService: DownloadImageServiceProtocol) {
        self.multimedia = multimedia
        self.downloadImageService = downloadImageService
    }
}

// MARK: - ArticleImageTableViewCellProtocol

extension ArticleImageTableCellViewModel: ArticleImageTableViewCellProtocol {
    var caption: String {
        var components: [String] = []
        if let caption = self.multimedia.caption,
            !caption.isEmpty {
            components.append(caption)
        }
        if let copyright = self.multimedia.copyright,
            !copyright.isEmpty {
            components.append(copyright)
        }
        return components.joined(separator: " | ")
    }
    
    var id: String {
        return self.multimedia.mediaData?.last?.url?.absoluteString ?? ""
    }
    
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        guard let imageURL = self.multimedia.mediaData?.last?.url else { return }
        self.downloadImageService.download(url: imageURL) { [weak self] (response) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                switch response {
                case .success(let image):
                    completion(strongSelf.id, .success(image))
                case .failure(let error):
                    completion(strongSelf.id, .failure(error))
                }
            }
        }
    }
}
