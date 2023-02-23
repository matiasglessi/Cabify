//
//  Discount.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

protocol Discount {
    var title: String { get }
    var itemCode: String { get }
    func apply(to cartItem: CartItem) -> Float
}

class BulkDiscount: Discount {
    var itemCode: String
    var title: String
    var minimunBulkSize: Int
    var discountPerItem: Float

    init(itemCode: String, title: String, minimunBulkSize: Int, discountPerItem: Float) {
        self.itemCode = itemCode
        self.title = title
        self.minimunBulkSize = minimunBulkSize
        self.discountPerItem = discountPerItem
    }
    
    func apply(to cartItem: CartItem) -> Float {
        cartItem.quantity >= minimunBulkSize ?
            Float(cartItem.quantity) * discountPerItem :
            0.0
    }
}

class XForYDiscount: Discount {
    var itemCode: String
    var title: String
    var itemsBought: Int
    var freeItems: Int

    init(itemCode: String, title: String, itemsBought: Int, freeItems: Int) {
        self.itemCode = itemCode
        self.title = title
        self.itemsBought = itemsBought
        self.freeItems = freeItems
    }
    
    func apply(to cartItem: CartItem) -> Float {
        let discountedItems = Int(cartItem.quantity / itemsBought)
        let totalDiscount = Float(discountedItems * freeItems) * cartItem.item.price
        return totalDiscount
    }
}
