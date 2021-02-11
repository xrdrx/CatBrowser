//
//  CatTableDelegate.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import UIKit

class CatTableDelegate: NSObject, UITableViewDelegate {
    
    private let viewModel: CatViewModel
    
    init(viewModel: CatViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if shouldGetMoreCats(currentPosition: indexPath.row) {
            viewModel.getMoreCats()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func shouldGetMoreCats(currentPosition: Int) -> Bool {
        let total = viewModel.getDataSize()
        return currentPosition == (total - 10)
    }
    
}
