//
//  NetworkService.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import Alamofire

class NetworkService {
    
    public func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping (Result<T, AFError>) -> Void) {
        let request = AF.request(url)
        request
            .validate()
            .responseDecodable(of: T.self) { (response) in
                completion(response.result)
            }
    }
    
}
