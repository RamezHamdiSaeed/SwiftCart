//
//  ShopifyAuthNetworkServiceImpl.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 07/06/2024.
//

import Foundation

class ShopifyAuthNetworkServiceImpl : ShopifyAuthNetworkService {
    static func createCustomer(customer: SignedUpCustomer) {
        AppCommon.networkingManager.networkingRequest(path: "/customers.json", queryItems: nil, method: .POST, requestBody: customer, networkResponse: { (result: Result<SignedUpCustomerResponse, NetworkError>) in
            switch result {
            case .success(let loggedInCustomerInfoResponse):
                print("this user is created at shopifyDB successfully \(loggedInCustomerInfoResponse.customer?.email)")
            case .failure(let error):
                print("network post Customer error: \(error.localizedDescription)")
            }
        })
    }
    
   static func getLoggedInCustomerByEmail(email: String){
        AppCommon.networkingManager.networkingRequest(path: "/customers/search.json", queryItems: [URLQueryItem(name: "query", value: email)], method: .GET, requestBody: nil, networkResponse: { (result: Result<LoggedInCustomers, NetworkError>) in
            switch result {
            case .success(let LoggedInCustomersInfoResponse):
                AppCommon.user.email = LoggedInCustomersInfoResponse.customers![0].email
                AppCommon.user.id = LoggedInCustomersInfoResponse.customers![0].id
                
                print("this userdata is fetched successfully from shopifyDB successfully \(LoggedInCustomersInfoResponse.customers![0].email)")
            case .failure(let error):
                print("network post Customer error: \(error.localizedDescription)")
            }
        })
    }
    
    
}
