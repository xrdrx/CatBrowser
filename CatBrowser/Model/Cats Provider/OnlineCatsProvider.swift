//
//  OnlineCatsProvider.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 11.02.2021.
//

class OnlineCatsProvider: CatsProvider {
    
    private let networkService: NetworkService
    private var linkProvider: CatLinkProvider
    private var data: [CatImageData]
    private weak var delegate: CatsProviderDelegate?
    
    init(catData: [CatImageData] = [], networkService: NetworkService = NetworkService(), linkProvider: CatLinkProvider = CatLinkProvider()) {
        self.data = catData
        self.networkService = networkService
        self.linkProvider = linkProvider
    }
    
    public func loadNewCats() {
        let link = linkProvider.getNextLink()
        networkService.fetch([CatImageData].self, from: link) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: data)
                self?.delegate?.didReceiveNewCats()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getDataSize() -> Int {
        return data.count
    }
    
    public func getData(forRow row: Int) -> CatImageData {
        return data[row]
    }
    
    public func setDelegate(_ delegate: CatsProviderDelegate) {
        self.delegate = delegate
    }

}
