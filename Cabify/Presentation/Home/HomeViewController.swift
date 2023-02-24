//
//  HomeViewController.swift
//  Cabify
//
//  Created by Matias Glessi on 17/02/2023.
//

import UIKit


class HomeViewController: UIViewController {
    private enum Constants {
        enum Font {
            static let big: CGFloat = 24
            static let medium: CGFloat = 16
        }
        enum Button {
            static let height: CGFloat = 48
            static let color: UIColor = UIColor(red: 0.36, green: 0.16, blue: 0.80, alpha: 1.00)
            static let cornerRadius: CGFloat = 8
        }
        enum Constraints {
            static let distance: CGFloat = 16
            static let buttonHeight: CGFloat = 48
        }
    }
    
    private var viewModel: HomeViewModel
    private var coordinator: AppCoordinator
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cabify's Shop"
        label.font = UIFont.systemFont(ofSize: Constants.Font.big, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.backgroundColor = Constants.Button.color
        button.layer.cornerRadius = Constants.Button.cornerRadius
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Font.medium, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: HomeViewModel, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        constructSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                self.showErrorAlert()
            }
        }
    }
    
    private func constructSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Constraints.distance),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.distance),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.distance),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Constraints.distance),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.distance),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.distance),
            tableView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -Constants.Constraints.distance)
        ])
        
        NSLayoutConstraint.activate([
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.distance),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.distance),
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Constraints.distance),
            checkoutButton.heightAnchor.constraint(equalToConstant: Constants.Constraints.buttonHeight)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        
        checkoutButton.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
    }
    
    @objc func checkoutTapped() {
        let cart = self.viewModel.cart()
        
        if !cart.isEmpty {
            coordinator.checkout(with: cart)
        }
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Someting went wrong", message: "Looks like something wrong happened loading the shop.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, ItemCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        let (item, discount) = self.viewModel.itemWithAssociatedDiscount(at: indexPath.row)
        cell.configure(with: item, discount: discount)
        cell.delegate = self
        return cell
    }
    
    func didUpdateQuantity(itemCode: String, quantity: Int) {
        self.viewModel.updatePreCheckoutCart(with: itemCode, quantity: quantity)
    }
}

protocol ItemCellDelegate: AnyObject {
    func didUpdateQuantity(itemCode: String, quantity: Int)
}
