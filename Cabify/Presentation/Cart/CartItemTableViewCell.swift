//
//  CartItemTableViewCell.swift
//  Cabify
//
//  Created by Matias Glessi on 24/02/2023.
//

import UIKit

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
