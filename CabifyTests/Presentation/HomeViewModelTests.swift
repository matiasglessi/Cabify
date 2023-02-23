//
//  HomeViewModelTests.swift
//  CabifyTests
//
//  Created by Matias Glessi on 23/02/2023.
//

import XCTest
@testable import Cabify

final class HomeViewModelTests: XCTestCase {
    func test_load_shouldLoadItemsAndDiscounts() {
        let sut = makeSUT()
        
        sut.load { result in
            switch result {
            case .success:
                XCTAssertEqual(sut.numberOfItems(), 1)
            case .failure:
                XCTFail("Expected success, got \(result) instead.")
            }
        }
    }
    
    func test_getItemWithDiscount_returnsAnItemAndADiscount() {
        let sut = makeSUT()
        sut.load { result in
            switch result {
            case .success:
                let (item, discount) = sut.itemWithAssociatedDiscount(at: sut.numberOfItems() - 1)
                XCTAssertEqual(item.code, discount?.itemCode)
                XCTAssertNotNil(discount)
            case .failure:
                XCTFail("Expected success, got \(result) instead.")
            }
        }
    }
    
    private func makeSUT() -> HomeViewModel {
        HomeViewModel(
            loadItemsService: ItemsLoaderMock(),
            loadDiscountsService: DiscountsLoaderMock()
        )
    }
    
    private class ItemsLoaderMock: ItemsLoader {
        func load(completion: @escaping (Cabify.LoadItemsResult) -> Void) {
            completion(.success([Item(code: "ITEM", name: "Name", price: 10)]))
        }
    }
    
    private class DiscountsLoaderMock: DiscountsLoader {
        func load() -> [Cabify.Discount] {
            [XForYDiscount(itemCode: "ITEM", title: "This is a discount title", itemsBought: 2, freeItems: 1)]
        }
    }
}
