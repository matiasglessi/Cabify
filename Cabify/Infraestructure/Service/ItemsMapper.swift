//
//  ItemsMapper.swift
//  Cabify
//
//  Created by Matias Glessi on 20/02/2023.
//

import Foundation

final class ItemsMapper {
    private struct Root: Decodable {
        let products: [Item]
    }
    
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> LoadItemsResult {
        guard response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            return .failure(DefaultItemsLoader.Error.invalidData)
        }
        
        return .success(root.products)
    }
}
