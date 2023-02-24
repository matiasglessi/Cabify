//
//  CartViewController.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import UIKit

class CartViewController: UIViewController {
    private enum Constants {
        enum Font {
            static let big: CGFloat = 24
            static let medium: CGFloat = 16
        }
        enum Constraints {
            static let titleHeight: CGFloat = 32
            static let priceWidth: CGFloat = 100
            static let shortDistance: CGFloat = 8
            static let longDistance: CGFloat = 16
        }
    }

    private var viewModel: CartViewModel
    private var coordinator: AppCoordinator

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Cart"
        label.font = UIFont.systemFont(ofSize: Constants.Font.big, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let subtotalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtotal"
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtotalValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discounted"
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountedValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.font = UIFont.systemFont(ofSize: Constants.Font.big, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let totalValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.big, weight: .bold)
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
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Constraints.longDistance),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.longDistance),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.longDistance),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.titleHeight)
        ])
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Constraints.longDistance),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.longDistance),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.longDistance),
            tableView.bottomAnchor.constraint(equalTo: subtotalTitleLabel.topAnchor, constant: -Constants.Constraints.longDistance)
        ])
        
        NSLayoutConstraint.activate([
            subtotalTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.longDistance),
            subtotalTitleLabel.trailingAnchor.constraint(equalTo: subtotalValueLabel.leadingAnchor, constant: -Constants.Constraints.longDistance),
            subtotalTitleLabel.bottomAnchor.constraint(equalTo: discountedTitleLabel.topAnchor, constant: -Constants.Constraints.shortDistance)
        ])
        
        NSLayoutConstraint.activate([
            subtotalValueLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constants.Constraints.longDistance),
            subtotalValueLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.priceWidth),
            subtotalValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.longDistance),
            subtotalValueLabel.leadingAnchor.constraint(equalTo: subtotalTitleLabel.trailingAnchor, constant: Constants.Constraints.longDistance),
            subtotalValueLabel.bottomAnchor.constraint(equalTo: discountedValueLabel.topAnchor, constant: -Constants.Constraints.shortDistance)
        ])
        
        NSLayoutConstraint.activate([
            discountedTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.longDistance),
            discountedTitleLabel.trailingAnchor.constraint(equalTo: discountedValueLabel.leadingAnchor, constant: -Constants.Constraints.longDistance),
            discountedTitleLabel.bottomAnchor.constraint(equalTo: totalTitleLabel.topAnchor, constant: -Constants.Constraints.longDistance)
        ])
        
        NSLayoutConstraint.activate([
            discountedValueLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.priceWidth),
            discountedValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.longDistance),
            discountedValueLabel.leadingAnchor.constraint(equalTo: discountedTitleLabel.trailingAnchor, constant: Constants.Constraints.longDistance),
            discountedValueLabel.bottomAnchor.constraint(equalTo: totalValueLabel.topAnchor, constant: -Constants.Constraints.longDistance)

        ])
        
        NSLayoutConstraint.activate([
            totalTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.longDistance),
            totalTitleLabel.trailingAnchor.constraint(equalTo: totalValueLabel.leadingAnchor, constant: -Constants.Constraints.longDistance),
        ])

        NSLayoutConstraint.activate([
            totalValueLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.priceWidth),
            totalValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.longDistance),
            totalValueLabel.leadingAnchor.constraint(equalTo: totalTitleLabel.trailingAnchor, constant: Constants.Constraints.longDistance),
            totalValueLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Constraints.longDistance),

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
    private enum Constants {
        enum Font {
            static let medium: CGFloat = 16
            static let small: CGFloat = 14
        }
        enum Constraints {
            static let shortDistance: CGFloat = 5
            static let mediumDistance: CGFloat = 8
            static let longDistance: CGFloat = 10
            static let quantityWidth: CGFloat = 30
            static let priceWidth: CGFloat = 60
        }
    }
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium, weight: .semibold)
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
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pricePerUnitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.small)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium, weight: .semibold)
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
            quantityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.mediumDistance),
            quantityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.shortDistance),
            quantityLabel.trailingAnchor.constraint(equalTo: productStackView.leadingAnchor, constant: -Constants.Constraints.longDistance),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.quantityWidth),
            quantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.mediumDistance)
        ])
        
        NSLayoutConstraint.activate([
            productStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.mediumDistance),
            productStackView.trailingAnchor.constraint(equalTo: totalPriceLabel.leadingAnchor, constant: -Constants.Constraints.mediumDistance),
            productStackView.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: Constants.Constraints.longDistance),
            productStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.mediumDistance)
        ])
        
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.mediumDistance),
            totalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.shortDistance),
            totalPriceLabel.leadingAnchor.constraint(equalTo: productStackView.trailingAnchor, constant: Constants.Constraints.mediumDistance),
            totalPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.mediumDistance),
            totalPriceLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.priceWidth)
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
