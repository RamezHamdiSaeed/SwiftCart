//
//  MockNetworkingManagerImpl.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

final class MockShopifyAuthNetworkServiceImpl : ShopifyAuthNetworkService {
    let networkingManager = NetworkingManagerImpl()
    
    func createCustomer(customer: SignedUpCustomer) {
        
        self.networkingManager.networkingRequest(path: "/customers.json", queryItems: nil, method: .POST, requestBody: customer,completeBaseURL: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04",networkResponse: { (result: Result<SignedUpCustomerResponse, NetworkError>) in
           switch result {
           case .success(let loggedInCustomerInfoResponse):
               print("this user is created at shopifyDB successfully \(loggedInCustomerInfoResponse.customer?.email)")
           case .failure(let error):
               print("network post Customer error: \(error.localizedDescription)")
           }
       })
    }
    
    func getLoggedInCustomerByEmail(email: String, whenSuccess: @escaping () -> ()) {
        self.networkingManager.networkingRequest(path: "/customers/search.json", queryItems: [URLQueryItem(name: "query", value: email)], method: .GET, requestBody: nil, completeBaseURL: nil, networkResponse: { (result: Result<LoggedInCustomers, NetworkError>) in
            switch result {
            case .success(let LoggedInCustomersInfoResponse):
                User.email = LoggedInCustomersInfoResponse.customers![0].email
                User.id = LoggedInCustomersInfoResponse.customers![0].id
                print("User id : \(User.id)")
                print("User email : \(User.email)")
                print("this userdata is fetched successfully from shopifyDB successfully \(LoggedInCustomersInfoResponse.customers![0].email)")
                whenSuccess()
            case .failure(let error):
                print("network post Customer error: \(error.localizedDescription)")
            }
        })
    }
    
  
    
}
