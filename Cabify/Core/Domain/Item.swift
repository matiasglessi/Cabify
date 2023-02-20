//
//  Item.swift
//  Cabify
//
//  Created by Matias Glessi on 20/02/2023.
//

import Foundation

struct Item: Equatable, Decodable {
    let code: String
    let name: String
    let price: Float
}
