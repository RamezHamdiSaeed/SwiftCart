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

struct AddressData: Decodable {
    var address1: String?
    var address2: String?
    var city: String?
    var country: String?
    var countryCode: String?
    var countryName: String?
    var company: String?
    var customerId:Int?
    

    enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case city
        case country
        case countryCode = "country_code"
        case countryName = "country_name"
        case company
        case customerId = "customer_id"
    }
}

struct CustomerId: Decodable {
    var id: Int?
     var email: String?
     var addresses: [Address]?
}

