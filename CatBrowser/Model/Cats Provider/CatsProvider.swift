//
//  CatsProvider.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

protocol CatsProvider {
    func loadNewCats()
    func getDataSize() -> Int
    func getData(forRow: Int) -> CatImageData
    func setDelegate(_ delegate: CatsProviderDelegate)
}

protocol CatsProviderDelegate: class {
    func didReceiveNewCats()
}
