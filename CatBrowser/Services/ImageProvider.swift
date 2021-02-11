//
//  ImageProvider.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import UIKit
import Kingfisher

struct ImageProvider {
    
    public func setImage(_ image: UIImageView, with url: URL, completion: @escaping () -> Void) {
        let processor = DownsamplingImageProcessor(size: image.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 10)
        image.kf.indicatorType = .activity
        let wasCached = ImageCache.default.isCached(forKey: url.absoluteString)
        image.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(_ ):
                if !wasCached {
                    completion()
                }
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    public func setOriginalImage(_ image: UIImageView, _ url: URL) {
        let cache = ImageCache.default
        guard cache.isCached(forKey: url.absoluteString) else { return }
        image.kf.setImage(with: url)
    }
    
}
