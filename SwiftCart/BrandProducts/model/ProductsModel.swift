//
//  ProductsModel.swift
//  SwiftCart
//
//  Created by marwa on 26/05/2024.
//

import Foundation

struct Variant: Codable {
    let id: Int
    let productId: Int
    let title: String
    let price: String
    let sku: String
    let position: Int
    let inventoryPolicy: String
    let compareAtPrice: String?
    let fulfillmentService: String
    let inventoryManagement: String
    let option1: String
    let option2: String
    let option3: String?
    let createdAt: String
    let updatedAt: String
    let taxable: Bool
    let barcode: String?
    let grams: Int
    let weight: Double
    let weightUnit: String
    let inventoryItemId: Int
    let inventoryQuantity: Int
    let oldInventoryQuantity: Int
    let requiresShipping: Bool
    let adminGraphqlApiId: String
    let imageId: String?
}

struct Option: Codable {
    let id: Int
    let productId: Int
    let name: String
    let position: Int
    let values: [String]
}

struct ImageProducts: Codable {
    let id: Int
    let alt: String?
    let position: Int
    let productId: Int
    let createdAt: String
    let updatedAt: String
    let adminGraphqlApiId: String
    let width: Int
    let height: Int
    let src: String
    let variantIds: [Int]
}

struct Product: Codable {
    let id: Int
    let title: String
    let bodyHtml: String
    let vendor: String
    let productType: String
    let createdAt: String
    let handle: String
    let updatedAt: String
    let publishedAt: String
    let templateSuffix: String?
    let publishedScope: String
    let tags: String
    let status: String
    let adminGraphqlApiId: String
    let variants: [Variant]
    let options: [Option]
    let images: [ImageProducts]
    let image: ImageProducts
}

// Root model
struct ProductResponse: Codable {
    let products: [Product]
}
