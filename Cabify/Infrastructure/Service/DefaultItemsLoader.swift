//
//  DefaultItemsLoader.swift
//  Cabify
//
//  Created by Matias Glessi on 20/02/2023.
//

import Foundation

class DefaultItemsLoader: ItemsLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (LoadItemsResult) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(ItemsMapper.map(data, from: response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
