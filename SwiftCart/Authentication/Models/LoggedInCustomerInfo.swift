//
//  LoggedInCustomerInfo.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 07/06/2024.
//

import Foundation



// MARK: - EmailMarketingConsent
struct EmailMarketingConsent: Codable {
    let state: String?
    let optInLevel: String?
    let consentUpdatedAt: String?

    enum CodingKeys: String, CodingKey {
        case state
        case optInLevel = "opt_in_level"
        case consentUpdatedAt = "consent_updated_at"
    }
}

// MARK: - Customer
struct LoggedInCustomerInfo: Codable {
    let id: Int?
    let email: String?
    let createdAt: String?
    let updatedAt: String?
    let firstName: String?
    let lastName: String?
    let ordersCount: Int?
    let state: String?
    let totalSpent: String?
    let lastOrderID: Int?
    let note: String?
    let verifiedEmail: Bool?
    let multipassIdentifier: String?
    let taxExempt: Bool?
    let tags: String?
    let lastOrderName: String?
    let currency: String?
    let phone: String?
    let addresses: [String]?
    let taxExemptions: [String]?
    let emailMarketingConsent: EmailMarketingConsent?
    let smsMarketingConsent: String?
    let adminGraphqlAPIID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case ordersCount = "orders_count"
        case state
        case totalSpent = "total_spent"
        case lastOrderID = "last_order_id"
        case note
        case verifiedEmail = "verified_email"
        case multipassIdentifier = "multipass_identifier"
        case taxExempt = "tax_exempt"
        case tags
        case lastOrderName = "last_order_name"
        case currency
        case phone
        case addresses
        case taxExemptions = "tax_exemptions"
        case emailMarketingConsent = "email_marketing_consent"
        case smsMarketingConsent = "sms_marketing_consent"
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}

// MARK: - Customers
struct LoggedInCustomers: Codable {
    let customers: [LoggedInCustomerInfo]?
}
struct LoggedInCustomer: Codable {
    let customer: [LoggedInCustomerInfo]?
}
