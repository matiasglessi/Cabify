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
        
        let expectation = expectation(description: "Wait for load completion")
        
        sut.load { result in
            switch result {
            case let .success(recievedDiscounts):
                XCTAssertEqual(recievedDiscounts.count, 2)
            default:
                XCTFail("Expected success, got \(result) instead.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
