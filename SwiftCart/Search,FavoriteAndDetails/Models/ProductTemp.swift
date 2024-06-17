//
//  ProductTemp.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import Foundation
struct ProductTemp: Codable {
    var id: Int
    var name: String
    var price: Double
    var isFavorite: Bool
    var image : String
    
    func toDictionary() -> [String: Any] {
            return [
                "id": id,
                "image": image,
                "price": price,
                "name": name
            ]
        }
}
