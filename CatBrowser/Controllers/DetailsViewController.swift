//
//  DetailsViewController.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var downloadDate: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var url: String?
    var storage: CatStorage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = url else { return }
        if let link = URL(string: url) {
            let data = storage?.getData(for: url)
            originalImage.kf.setImage(with: link)
            downloadDate.text = data?.first?.date?.description
        }
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = scrollView.frame.size.width / originalImage.frame.size.width
        scrollView.maximumZoomScale = 6.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return originalImage
    }
    
}
