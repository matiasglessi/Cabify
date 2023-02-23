//
//  CartViewModelTests.swift
//  CabifyTests
//
//  Created by Matias Glessi on 23/02/2023.
//

import XCTest
@testable import Cabify

final class CartViewModelTests: XCTestCase {
    func test_onCalculateSubtotal_returnsTheSumOfAllCartItemsMultipliedByItsQuantity() {
        let cart = [
            CartItem(item: Item(code: "A CODE", name: "A NAME", price: 10), quantity: 3),
            CartItem(item: Item(code: "ANOTHER CODE", name: "ANOTHER NAME", price: 5), quantity: 2),
        ]
        
        let sut = CartViewModel(cart: cart)
        
        let subtotal = sut.subtotal()
        
        XCTAssertEqual(subtotal, 10*3 + 5*2)
    }
    
    func test_onCalculateAppliedDiscount_withNoDiscounts_returnsZero() {
        let cart = [
            CartItem(item: Item(code: "A CODE", name: "A NAME", price: 10), quantity: 3),
            CartItem(item: Item(code: "ANOTHER CODE", name: "ANOTHER NAME", price: 5), quantity: 2),
        ]

        let sut = CartViewModel(cart: cart)
        
        let totalDiscount = sut.totalDiscount()
        
        XCTAssertEqual(totalDiscount, 0.0)
    }
    
    func test_onCalculateAppliedDiscount_withDiscounts_returnsTheSumOfAllDiscounts() {
        let cart = [
            CartItem(item: Item(code: "A CODE", name: "A NAME", price: 10), quantity: 3),
            CartItem(
                item: Item(code: "ANOTHER CODE", name: "ANOTHER NAME", price: 5),
                quantity: 3,
                discount: XForYDiscount(itemCode: "ANOTHER CODE", title: "Title", itemsBought: 2, freeItems: 1))
        ]
        
        let sut = CartViewModel(cart: cart)
        
        let totalDiscount = sut.totalDiscount()
        
        XCTAssertEqual(totalDiscount, 5.0)
    }
}
