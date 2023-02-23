//
//  HomeViewModel.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

enum HomeViewModelLoadResult {
    case success
    case failure
}

class HomeViewModel {
    private let loadItemsService: ItemsLoader
    private let loadDiscountsService: DiscountsLoader
    private var items = [Item]()
    private var discounts = [Discount]()
    
    init(loadItemsService: ItemsLoader, loadDiscountsService: DiscountsLoader) {
        self.loadItemsService = loadItemsService
        self.loadDiscountsService = loadDiscountsService
    }
    
    func load(completion: @escaping (HomeViewModelLoadResult) -> Void) {
        loadItemsService.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(recievedItems):
                self.items = recievedItems
                self.discounts = self.loadDiscountsService.load()
                completion(.success)
            case .failure(_):
                completion(.failure)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func itemWithAssociatedDiscount(at index: Int) -> (Item, Discount?) {
        let item = items[index]
        return (item, discount(for: item.code))
    }
    
    private func discount(for itemCode: String) -> Discount? {
        discounts.filter { $0.itemCode == itemCode }.first
    }
}
