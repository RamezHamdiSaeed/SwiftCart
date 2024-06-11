// Adresses.swift
// SwiftCart
//
// Created by rwan elmtary on 26/05/2024.
//

import Foundation
import CoreLocation

// MARK: - AddressDataModel
struct AddressDataModel: Codable {
    let addresses: [Address]?
}

// MARK: - Address
struct Address: Codable {
    let id, customerID: Int?
    let firstName, lastName, company: String?
    let address1, address2, city, province: String?
    let country, zip, phone, name: String?
    let provinceCode, countryCode, countryName: String?
    let addressDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company, address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case addressDefault = "default"
    }
}
struct PostCustomerAddress: Codable {
    let address: AddressData?
}

struct PostAddressResponse: Codable {
    let customerAddress: Address?

    enum CodingKeys: String, CodingKey {
        case customerAddress = "customer_address"
    }
}

// MARK: - Address
struct AddressData: Codable {
    let address1, address2, city, company: String?
    let firstName, lastName, phone, province: String?
    let country, zip, name, provinceCode: String?
    let countryCode, countryName: String?

    enum CodingKeys: String, CodingKey {
        case address1, address2, city, company
        case firstName = "first_name"
        case lastName = "last_name"
        case phone, province, country, zip, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
    }
}
