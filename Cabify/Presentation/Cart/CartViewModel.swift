//
//  CartViewModel.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

class CartViewModel {
    private let cart: [CartItem]
    
    init(cart: [CartItem]) {
        self.cart = cart
    }
    
    func subtotal() -> Float {
        var subtotal: Float = 0.0
        cart.forEach { cartItem in
            subtotal = subtotal + cartItem.subtotal
        }
        return subtotal
    }
    
    func totalDiscount() -> Float {
        var totalDiscount: Float = 0.0
        cart.forEach { cartItem in
            totalDiscount = totalDiscount + cartItem.appliedDiscount
        }
        return totalDiscount
    }
    
    func total() -> Float {
        subtotal() - totalDiscount()
    }
    
    func numberOfItems() -> Int {
        return cart.count
    }
    
    func cartItem(at index: Int) -> CartItem {
        return cart[index]
    }
}
