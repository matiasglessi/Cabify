//
//  DiscountsLoader.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

enum LoadDiscountsResult {
    case success([Discount])
    case failure(Error)
}

protocol DiscountsLoader {
    func load(completion: @escaping (LoadDiscountsResult) -> Void)
}
