//
//  CartResponse.swift
//  SwiftCart
//
//  Created by rwan elmtary on 07/06/2024.
//

import Foundation
import Foundation

// MARK: - DraftOrderResponse
struct DraftOrderResponse: Decodable {
    let draftOrder: DraftOrder

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

// MARK: - DraftOrder
struct DraftOrder: Decodable {
    let lineItems: [LineItem]
    let customer: Customr
    let useCustomerDefaultAddress: Bool

    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
        case customer
        case useCustomerDefaultAddress = "use_customer_default_address"
    }
}

// MARK: - LineItem
struct LineItem: Decodable {
    let variantID: Int
    let quantity: Int
    let price: String
    let title: String
    let taxable: Bool

    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case quantity
        case price
        case title
        case taxable
    }
}
struct Customr: Decodable {
    let id: Int
}


