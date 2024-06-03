// Adresses.swift
// SwiftCart
//
// Created by rwan elmtary on 26/05/2024.
//

import Foundation
import CoreLocation

struct Address: Decodable {
    var city: String?
    var address2: String?
}

struct Customer: Decodable {
    var verified_email: Bool?
    var first_name: String?
    var addresses: [Address]?
}

struct CustomerResponse: Decodable {
    var customer: Customer?
}
