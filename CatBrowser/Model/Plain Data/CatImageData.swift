//
//  CatImageData.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

struct CatImageData: Codable, Equatable {
    let breeds: [CatInfo]
    let id: String
    let url: String
    let width: Int
    let height: Int
}
