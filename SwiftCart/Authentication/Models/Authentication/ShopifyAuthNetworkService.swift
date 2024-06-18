//
//  ShopifyAuthNetworkService.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 07/06/2024.
//

import Foundation

protocol ShopifyAuthNetworkService{
     func createCustomer(customer: SignedUpCustomer)
     func getLoggedInCustomerByEmail(email : String,whenSuccess:@escaping()->())
}
