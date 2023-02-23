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
    func apply()
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
    
    func apply() {
        
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
    
    func apply() {
        
    }
}
