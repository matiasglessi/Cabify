//
//  DefaultDiscountsLoader.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

class DefaultDiscountsLoader: DiscountsLoader {
    let discounts: [Discount] = [
        XForYDiscount(
            title: "Buy 2 - get one for free!",
            itemsBought: 2,
            freeItems: 1),
        BulkDiscount(
            title: "Buy 3 or more - get each for 19€",
            minimunBulkSize: 3,
            discountPerItem: 1)
    ]
    
    func load(completion: @escaping (LoadDiscountsResult) -> Void) {
        completion(.success(discounts))
    }
}
