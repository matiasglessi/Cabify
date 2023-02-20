//
//  ItemsLoader.swift
//  Cabify
//
//  Created by Matias Glessi on 20/02/2023.
//

import Foundation

enum LoadItemsResult {
    case success([Item])
    case failure(Error)
}

protocol ItemsLoader {
    func load(completion: @escaping (LoadItemsResult) -> Void)
}
