//
//  BrandModel.swift
//  SwiftCart
//
//  Created by marwa on 24/05/2024.
//

import Foundation
struct SmartCollection: Codable {
    let id: Int
    let handle: String
    let title: String
    let updatedAt: String
    let bodyHtml: String
    let publishedAt: String
    let sortOrder: String
    let templateSuffix: String?
    let disjunctive: Bool
    let rules: [Rule]
    let publishedScope: String
    let adminGraphqlApiId: String
    let image: Image
}

struct Rule: Codable {
    let column: String
    let relation: String
    let condition: String
}

struct Image: Codable {
    let createdAt: String
    let alt: String?
    let width: Int
    let height: Int
    let src: String
}

struct SmartCollectionsResponse: Codable {
    let smartCollections: [SmartCollection]
}
