//
//  ItemTableViewCell.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    private enum Constants {
        enum Font {
            static let big: CGFloat = 18
            static let small: CGFloat = 14
        }
        enum Constraints {
            static let longDistance: CGFloat = 16
            static let shortDistance: CGFloat = 8
            static let quantityWidth: CGFloat = 32
        }
    }
    
    private var item: Item?
    weak var delegate: ItemCellDelegate?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.big, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.small, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.small, weight: .bold)
        label.textColor = .systemGreen
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Font.big, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(quantityStepper)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.shortDistance),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.longDistance),
            titleLabel.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -Constants.Constraints.longDistance),
            titleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -Constants.Constraints.shortDistance)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.longDistance),
            priceLabel.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -Constants.Constraints.longDistance),
            priceLabel.bottomAnchor.constraint(equalTo: discountLabel.topAnchor, constant: -Constants.Constraints.shortDistance)
        ])

        NSLayoutConstraint.activate([
            discountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.longDistance),
            discountLabel.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -Constants.Constraints.longDistance),
            discountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.shortDistance)
        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.quantityWidth),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: quantityStepper.leadingAnchor, constant: -Constants.Constraints.longDistance)
        ])
        
        NSLayoutConstraint.activate([
            quantityStepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityStepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.longDistance)
        ])
        
        quantityStepper.addTarget(self, action: #selector(quantityStepperValueChanged), for: .valueChanged)
    }
    
    @objc private func quantityStepperValueChanged(sender: UIStepper) {
        let quantityValue = Int(sender.value)
        quantityLabel.text = quantityValue > 0 ? "\(quantityValue)" : ""
        
        guard let item = item else { return }
        delegate?.didUpdateQuantity(itemCode: item.code, quantity: quantityValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: Item, discount: Discount?) {
        self.item = item
        self.titleLabel.text = item.name
        self.priceLabel.text = "$\(item.price)0"
        self.discountLabel.text = discount?.title ?? ""
        self.quantityLabel.text = "0"
        self.quantityStepper.value = 0
    }
}
