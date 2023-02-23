//
//  DefaultDiscountsLoaderTests.swift
//  CabifyTests
//
//  Created by Matias Glessi on 21/02/2023.
//

import XCTest
@testable import Cabify

final class DefaultDiscountsLoaderTests: XCTestCase {
    
    func test_load_getsDiscountsList() {
        let sut = DefaultDiscountsLoader()
        let recievedDiscounts = sut.load()
        XCTAssertEqual(recievedDiscounts.count, 2)
    }
}
