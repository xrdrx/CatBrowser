//
//  CatStorage.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 11.02.2021.
//

import CoreData

struct CatStorage {
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.viewContext
    }
    
    public func getData(for url: String) -> [CatData] {
        let request = catDataRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        return performRequest(request)
    }
    
    public func save(_ data: CatImageData) {
        let url = data.url
        let width = data.width
        let height = data.height
        
        let catData = CatData(context: context)
        catData.date = Date()
        catData.height = Int32(height)
        catData.width = Int32(width)
        catData.url = url
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    public func getRecords(number: Int, offset: Int) -> [CatData] {
        let request = catDataRequest()
        request.fetchLimit = number
        request.fetchOffset = offset
        return performRequest(request)
    }
    
    public func getNumberOfRecords() -> Int {
        do {
            return try context.count(for: catDataRequest())
        } catch {
            return 0
        }
    }
    
    private func catDataRequest() -> NSFetchRequest<CatData> {
        return NSFetchRequest<CatData>(entityName: "CatData")
    }
    
    private func performRequest(_ request: NSFetchRequest<CatData>) -> [CatData] {
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Error fetching data")
            return []
        }
    }
    
}
