//
//  Currency.swift
//  SwiftCart
//
//  Created by rwan elmtary on 31/05/2024.
//

//import Foundation
//
//struct Currency: Codable {
//    let moode: Int
//    let contact: String
//    let about: String
//    let currency: String
//    let address: String
//    let logout: Bool
//}
import Foundation

struct Currency: Codable {
    let code: String
    let rate: Double
}
