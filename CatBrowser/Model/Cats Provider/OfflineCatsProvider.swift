//
//  OfflineCatsProvider.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 11.02.2021.
//

class OfflineCatsProvider: CatsProvider {
    
    private let storage: CatStorage
    private var data: [CatImageData]
    private weak var delegate: CatsProviderDelegate?
    private var offset: Int
    
    init(storage: CatStorage) {
        self.storage = storage
        self.data = []
        self.offset = 0
    }
    
    public func loadNewCats() {
        if offset > storage.getNumberOfRecords() { return }
        
        let cats = storage.getRecords(number: 30, offset: offset)
        offset += 30
        let catsImageData = cats.map {
            CatImageData(
            breeds: [],
            id: "",
            url: $0.url ?? "",
            width: Int($0.width),
            height: Int($0.height)
            )}
        data.append(contentsOf: catsImageData)
        delegate?.didReceiveNewCats()
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
