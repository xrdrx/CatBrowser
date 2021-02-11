//
//  CatTableDataSource.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import Foundation
import UIKit

class CatTableDataSource: NSObject, UITableViewDataSource {
    
    private let viewModel: CatViewModel
    
    init(viewModel: CatViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableCell", for: indexPath) as! CatTableViewCell
        viewModel.configure(cell, for: indexPath.row)
        return cell
    }
    
}
