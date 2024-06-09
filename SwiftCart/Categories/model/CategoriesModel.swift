//
//  CategoriesModel.swift
//  SwiftCart
//
//  Created by marwa on 29/05/2024.
//

import Foundation


enum Categories : String {
    
    case Men = "422258901243"
    case Women = "422258934011"
    case Kids = "422258966779"
    case Sale = "422258999547"
    
}

struct ProductsResponse: Codable {
    let products: [Product]
}
