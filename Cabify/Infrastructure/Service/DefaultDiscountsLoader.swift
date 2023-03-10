//
//  DefaultDiscountsLoader.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

class DefaultDiscountsLoader: DiscountsLoader {
    private let discounts: [Discount] = [
        XForYDiscount(
            itemCode: "VOUCHER",
            title: "Buy 2 - get one for free!",
            itemsBought: 2,
            freeItems: 1),
        BulkDiscount(
            itemCode: "TSHIRT",
            title: "Buy 3 or more - get each for 19€",
            minimunBulkSize: 3,
            discountPerItem: 1)
    ]
    
    func load() -> [Discount] {
        discounts
    }
}
