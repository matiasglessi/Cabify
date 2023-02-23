//
//  Discount.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

protocol Discount {
    var title: String { get }
    func apply()
}

class BulkDiscount: Discount {
    var title: String
    var minimunBulkSize: Int
    var discountPerItem: Float

    init(title: String, minimunBulkSize: Int, discountPerItem: Float) {
        self.title = title
        self.minimunBulkSize = minimunBulkSize
        self.discountPerItem = discountPerItem
    }
    
    func apply() {
        
    }
}

class XForYDiscount: Discount {
    var title: String
    var itemsBought: Int
    var freeItems: Int

    init(title: String, itemsBought: Int, freeItems: Int) {
        self.title = title
        self.itemsBought = itemsBought
        self.freeItems = freeItems
    }
    
    func apply() {
        
    }
}
