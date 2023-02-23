//
//  DiscountsLoader.swift
//  Cabify
//
//  Created by Matias Glessi on 23/02/2023.
//

import Foundation

protocol DiscountsLoader {
    func load() -> [Discount]
}
