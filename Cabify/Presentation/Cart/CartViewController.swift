//
//  CartViewController.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import UIKit

class CartViewController: UIViewController {
    
    private var viewModel: CartViewModel
    private var coordinator: AppCoordinator

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Cart"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let subtotalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtotal"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtotalValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discounted"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountedValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let totalValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: CartViewModel, coordinator: AppCoordinator) {
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
        setCartPrices()
    }
    
    private func constructSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(subtotalTitleLabel)
        view.addSubview(subtotalValueLabel)
        view.addSubview(discountedTitleLabel)
        view.addSubview(discountedValueLabel)
        view.addSubview(totalTitleLabel)
        view.addSubview(totalValueLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: subtotalTitleLabel.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            subtotalTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtotalTitleLabel.trailingAnchor.constraint(equalTo: subtotalValueLabel.leadingAnchor, constant: -16),
            subtotalTitleLabel.bottomAnchor.constraint(equalTo: discountedTitleLabel.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            subtotalValueLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            subtotalValueLabel.widthAnchor.constraint(equalToConstant: 100),
            subtotalValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            subtotalValueLabel.leadingAnchor.constraint(equalTo: subtotalTitleLabel.trailingAnchor, constant: 16),
            subtotalValueLabel.bottomAnchor.constraint(equalTo: discountedValueLabel.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            discountedTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            discountedTitleLabel.trailingAnchor.constraint(equalTo: discountedValueLabel.leadingAnchor, constant: -16),
            discountedTitleLabel.bottomAnchor.constraint(equalTo: totalTitleLabel.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            discountedValueLabel.widthAnchor.constraint(equalToConstant: 100),
            discountedValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            discountedValueLabel.leadingAnchor.constraint(equalTo: discountedTitleLabel.trailingAnchor, constant: 16),
            discountedValueLabel.bottomAnchor.constraint(equalTo: totalValueLabel.topAnchor, constant: -16)

        ])
        
        NSLayoutConstraint.activate([
            totalTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalTitleLabel.trailingAnchor.constraint(equalTo: totalValueLabel.leadingAnchor, constant: -16),
        ])

        NSLayoutConstraint.activate([
            totalValueLabel.widthAnchor.constraint(equalToConstant: 100),
            totalValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            totalValueLabel.leadingAnchor.constraint(equalTo: totalTitleLabel.trailingAnchor, constant: 16),
            totalValueLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),

        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: "CartItemTableViewCell")
    }
    
    private func setCartPrices() {
        self.subtotalValueLabel.text = "$\(self.viewModel.subtotal())0"
        self.discountedValueLabel.text = "$\(self.viewModel.totalDiscount())0"
        self.totalValueLabel.text = "$\(self.viewModel.total())0"
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
        let cartItem = viewModel.cartItem(at: indexPath.row)
        cell.configure(with: cartItem)
        return cell
    }
}

class CartItemTableViewCell: UITableViewCell {
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pricePerUnitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(productStackView)
        contentView.addSubview(totalPriceLabel)
        
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            quantityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            quantityLabel.trailingAnchor.constraint(equalTo: productStackView.leadingAnchor, constant: -10),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 30),
            quantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            productStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productStackView.trailingAnchor.constraint(equalTo: totalPriceLabel.leadingAnchor, constant: -8),
            productStackView.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 10),
            productStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            totalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            totalPriceLabel.leadingAnchor.constraint(equalTo: productStackView.trailingAnchor, constant: 8),
            totalPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            totalPriceLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        

        productStackView.addArrangedSubview(nameLabel)
        productStackView.addArrangedSubview(pricePerUnitLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cartItem: CartItem) {
        quantityLabel.text = "\(cartItem.quantity)"
        nameLabel.text = cartItem.item.name
        pricePerUnitLabel.text = "$\(cartItem.item.price)0"
        totalPriceLabel.text = "$\(cartItem.item.price * Float(cartItem.quantity))0"
    }
}
