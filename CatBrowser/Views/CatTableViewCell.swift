//
//  CatTableViewCell.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import UIKit

class CatTableViewCell: UITableViewCell {

    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
