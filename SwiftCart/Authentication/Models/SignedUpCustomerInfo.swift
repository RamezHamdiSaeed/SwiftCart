//
//  Customer.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 07/06/2024.
//

import Foundation

struct SignedUpCustomerInfo: Codable {
    var email: String?
    var verifiedEmail: Bool?
    var state: String?

    enum CodingKeys: String, CodingKey {
        case email
        case verifiedEmail = "verified_email"
        case state
    }
}

struct SignedUpCustomer : Codable{
    var customer : SignedUpCustomerInfo?
}
struct SignedUpCustomerResponse : Codable{
    var customer : LoggedInCustomerInfo?
}

struct Errors: Codable {
    let email: [String]?
}

// MARK: - ErrorWrapper
struct ErrorWrapper: Codable {
    let errors: Errors?
}
