//
//  ProductTemp.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import Foundation
struct ProductTemp: Codable {
    let id: String
    let name: String
    let price: Double
    var isFavorite: Bool
    var image : String
}
