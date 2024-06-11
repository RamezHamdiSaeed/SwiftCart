//
//  CartResponse.swift
//  SwiftCart
//
//  Created by rwan elmtary on 07/06/2024.
//

import Foundation

// MARK: - PostDraftOrderResponse
struct PostDraftOrderResponse: Decodable {
    let draftOrder: DraftOrder?
    
    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

// MARK: - DraftOrdersResponse
struct DraftOrdersResponse: Decodable {
    let draftOrders: [DraftOrder]?
    
    enum CodingKeys: String, CodingKey {
        case draftOrders = "draft_orders"
    }
}

// MARK: - DraftOrder
struct DraftOrder: Decodable {
    let id: Int?
    let note, email: String?
    let taxesIncluded: Bool?
    let currency: String?
    let invoiceSentAt: String?
    let createdAt, updatedAt: String?
    let taxExempt: Bool?
    let completedAt: String?
    let name, status: String?
    let lineItems: [LineItems]?
    let shippingAddress, billingAddress: Address?
    let invoiceURL: String?
    let appliedDiscount: AppliedDiscount?
    let orderID: Int?
    let shippingLine: ShippingLine?
    let tags: String?
    let totalPrice, subtotalPrice, totalTax: String?
    let adminGraphqlAPIID: String?
    let customer: Customer?

    enum CodingKeys: String, CodingKey {
        case id, note, email
        case taxesIncluded = "taxes_included"
        case currency
        case invoiceSentAt = "invoice_sent_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxExempt = "tax_exempt"
        case completedAt = "completed_at"
        case name, status
        case lineItems = "line_items"
        case shippingAddress = "shipping_address"
        case billingAddress = "billing_address"
        case invoiceURL = "invoice_url"
        case appliedDiscount = "applied_discount"
        case orderID = "order_id"
        case shippingLine = "shipping_line"
        case tags
        case totalPrice = "total_price"
        case subtotalPrice = "subtotal_price"
        case totalTax = "total_tax"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case customer
    }
}

// MARK: - AppliedDiscount
struct AppliedDiscount: Decodable {
    let description, value: String?
    let title: String?
    let amount, valueType: String?

    enum CodingKeys: String, CodingKey {
        case description, value, title, amount
        case valueType = "value_type"
    }
}

// MARK: - LineItem
struct LineItems: Decodable {
    let id: Int?
    let variantID, productID: Int?
    let title: String?
    let variantTitle: String?
    let productImage: String?
    let vendor: String?
    let quantity: Int?
    let requiresShipping, taxable, giftCard: Bool?
    let fulfillmentService: String?
    let grams: Int?
    let appliedDiscount: Bool?
    let name: String?
    let custom: Bool?
    //let src: String?
    let price, adminGraphqlAPIID: String?
    let properties: [Property]?

    enum CodingKeys: String, CodingKey {
        case id
        case variantID = "variant_id"
        case productID = "product_id"
        case title
        case variantTitle = "variant_title"
        case productImage = "product_image"
        case vendor, quantity
        case requiresShipping = "requires_shipping"
        case taxable
        case giftCard = "gift_card"
        case fulfillmentService = "fulfillment_service"
        case grams
        case appliedDiscount = "applied_discount"
        case name, custom, price
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case properties
    }
}

// MARK: - Property Of selected Item
struct Property: Codable {
    let name: String?
    let value: String?
}

// MARK: - Address
//struct Address: Decodable {
//    let firstName: String?
//    let address1: String?
//    let phone: String?
//    let city: String?
//    let zip: String?
//    let province: String?
//    let country: String?
//    let lastName: String?
//    let address2: String?
//    let company: String?
//    let latitude: Double?
//    let longitude: Double?
//    let name: String?
//    let countryCode: String?
//    let provinceCode: String?
//}

// MARK: - Customer
struct Customer: Decodable {
    let id: Int?
    let email: String?
    let acceptsMarketing: Bool?
    let createdAt: String?
    let updatedAt: String?
    let firstName: String?
    let lastName: String?
    let ordersCount: Int?
    let state: String?
    let totalSpent: String?
    let lastOrderId: Int?
    let note: String?
    let verifiedEmail: Bool?
    let multipassIdentifier: String?
    let taxExempt: Bool?
    let phone: String?
    let tags: String?
    let lastOrderName: String?
    let currency: String?
    let acceptsMarketingUpdatedAt: String?
    let marketingOptInLevel: String?
    let taxExemptions: [String]?
    let adminGraphqlApiId: String?
    let defaultAddress: Address?
}

// MARK: - ShippingLine
struct ShippingLine: Codable {
    let title: String?
    let custom: Bool?
    let handle: String?
    let price: String?
}

// MARK: - DraftOrderRequestBody
struct DraftOrderRequestBody: Encodable {
    let lineItems: [LineItemRequest]
    let customer: CustomerID
    let useCustomerDefaultAddress: Bool
    
    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
        case customer
        case useCustomerDefaultAddress = "use_customer_default_address"
    }
}

// MARK: - LineItemRequest
struct LineItemRequest: Encodable {
    let variantID: Int
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case quantity
    }
}

// MARK: - CustomerID
struct CustomerID: Encodable {
    let id: Int
}

// MARK: - DraftOrderRequest
struct DraftOrderRequest: Encodable {
    let draftOrder: DraftOrderRequestBody
    
    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}
