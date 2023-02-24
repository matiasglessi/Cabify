//
//  Coordinator.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    private static let itemsEndpoint = "https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json"
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let discountsLoader = DefaultDiscountsLoader()
        let itemsLoader = DefaultItemsLoader(url: URL(string: AppCoordinator.itemsEndpoint)!, client: URLSessionHTTPClient())
        let viewModel = HomeViewModel(loadItemsService: itemsLoader, loadDiscountsService: discountsLoader)
        let homeViewController = HomeViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func checkout(with cart: [CartItem]) {
        let cartViewModel = CartViewModel(cart: cart)
        let cartViewController = CartViewController(viewModel: cartViewModel, coordinator: self)
        navigationController.pushViewController(cartViewController, animated: true)
    }
}
