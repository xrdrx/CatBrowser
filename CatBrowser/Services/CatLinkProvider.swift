//
//  CatLinkProvider.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import Foundation

struct CatLinkProvider {
    
    private let parentLink = "https://api.thecatapi.com/v1/images/search"
    private let itemsPerPage: Int
    private var page: Int
    private var link: String
    
    init(itemsPerPage: Int = 30, firstPage: Int = 0) {
        self.itemsPerPage = itemsPerPage
        self.page = firstPage
        self.link = ""
    }
    
    mutating func getNextLink() -> String {
        let result = "\(parentLink)?limit=\(itemsPerPage)&page=\(page)&order=Desc"
        page += 1
        return result
    }
}
