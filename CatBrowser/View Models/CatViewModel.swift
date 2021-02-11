//
//  CatViewModel.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import Foundation
import UIKit

protocol CatViewModelDelegate: class {
    func didReceiveUpdates()
}

class CatViewModel {
    
    private var catsProvider: CatsProvider
    private let imageProvider: ImageProvider
    private var storage: CatStorage?
    private weak var delegate: CatViewModelDelegate?
    
    init(catsProvider: CatsProvider = OnlineCatsProvider(), imageProvider: ImageProvider = ImageProvider()) {
        self.catsProvider = catsProvider
        self.imageProvider = imageProvider
        catsProvider.setDelegate(self)
    }
    
    public func setStorage(_ storage: CatStorage) {
        self.storage = storage
    }
    
    public func setCatsProvider(_ provider: CatsProvider) {
        self.catsProvider = provider
        catsProvider.setDelegate(self)
    }
    
    public func setDelegate(_ delegate: CatViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func getDataSize() -> Int {
        return catsProvider.getDataSize()
    }
    
    public func getData(forRow row: Int) -> CatImageData {
        return catsProvider.getData(forRow: row)
    }
    
    public func setOriginalImage(_ image: UIImageView, for row: Int) {
        let data = getData(forRow: row)
        guard let url = URL(string: data.url) else {
            return
        }
        imageProvider.setOriginalImage(image, url)
    }
    
    public func getMoreCats() {
        catsProvider.loadNewCats()
    }
    
    public func configure(_ cell: CatTableViewCell, for row: Int) {
        let catData = getData(forRow: row)
        cell.imageLabel.text = "Original image size: \(catData.width) x \(catData.height)"
        guard let url = URL(string: catData.url) else {
            cell.catImage.image = nil
            return
        }
        imageProvider.setImage(cell.catImage, with: url) { [weak self] in
            self?.storage?.save(catData)
        }
    }
    
}

extension CatViewModel: CatsProviderDelegate {
    func didReceiveNewCats() {
        delegate?.didReceiveUpdates()
    }
}
