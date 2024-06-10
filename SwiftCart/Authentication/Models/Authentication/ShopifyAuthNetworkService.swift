//
//  ShopifyAuthNetworkService.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 07/06/2024.
//

import Foundation

protocol ShopifyAuthNetworkService{
    static func createCustomer(customer: SignedUpCustomer)
    static func getLoggedInCustomerByEmail(email : String,whenSuccess:@escaping()->())
}
