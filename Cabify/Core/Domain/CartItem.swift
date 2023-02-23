//
//  CartItem.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

struct CartItem {
    let item: Item
    let quantity: Int
    let discount: Discount?
    
    init(item: Item, quantity: Int, discount: Discount? = nil) {
        self.item = item
        self.quantity = quantity
        self.discount = discount
    }
    
    var subtotal: Float {
        return item.price * Float(quantity)
    }
    
    var appliedDiscount: Float {
        guard let discount = discount else { return 0.0 }
        return discount.apply(to: self)
    }
}

