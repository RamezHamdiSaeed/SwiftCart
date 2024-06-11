//
//  ProductDetailsResponse.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 04/06/2024.
//

import Foundation

struct ProductDetailsResponse: Codable {
    let product: ProductDetails?
}

struct ProductDetails: Codable {
    let id: Int?
    let title: String?
    let bodyHtml: String?
    let vendor: String?
    let productType: String?
    let createdAt: String?
    let handle: String?
    let updatedAt: String?
    let publishedAt: String?
    let templateSuffix: String?
    let publishedScope: String?
    let tags: String?
    let status: String?
    let adminGraphqlApiId: String?
    let variants: [ProductDetailsVariant]?
    let options: [ProductDetailsOption]?
    let images: [ProductDetailsImage]?
    let image: ProductDetailsImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case bodyHtml = "body_html"
        case vendor
        case productType = "product_type"
        case createdAt = "created_at"
        case handle
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case templateSuffix = "template_suffix"
        case publishedScope = "published_scope"
        case tags
        case status
        case adminGraphqlApiId = "admin_graphql_api_id"
        case variants
        case options
        case images
        case image
    }
}

struct ProductDetailsVariant: Codable {
    let id: Int?
    let productId: Int64?
    let title: String?
    let price: String?
    let sku: String?
    let position: Int?
    let inventoryPolicy: String?
    let compareAtPrice: String?
    let fulfillmentService: String?
    let inventoryManagement: String?
    let option1: String?
    let option2: String?
    let option3: String?
    let createdAt: String?
    let updatedAt: String?
    let taxable: Bool?
    let barcode: String?
    let grams: Int?
    let weight: Double?
    let weightUnit: String?
    let inventoryItemId: Int64?
    let inventoryQuantity: Int?
    let oldInventoryQuantity: Int?
    let requiresShipping: Bool?
    let adminGraphqlApiId: String?
    let imageId: Int64?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case title
        case price
        case sku
        case position
        case inventoryPolicy = "inventory_policy"
        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
        case inventoryManagement = "inventory_management"
        case option1
        case option2
        case option3
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable
        case barcode
        case grams
        case weight
        case weightUnit = "weight_unit"
        case inventoryItemId = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case imageId = "image_id"
    }
}

struct ProductDetailsOption: Codable {
    let id: Int64?
    let productId: Int64?
    let name: String?
    let position: Int?
    let values: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case name
        case position
        case values
    }
}

struct ProductDetailsImage: Codable {
    let id: Int?
    let alt: String?
    let position: Int?
    let productId: Int64?
    let createdAt: String?
    let updatedAt: String?
    let adminGraphqlApiId: String?
    let width: Int?
    let height: Int?
    let src: String?
    let variantIds: [Int64]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case alt
        case position
        case productId = "product_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case width
        case height
        case src
        case variantIds = "variant_ids"
    }
}
