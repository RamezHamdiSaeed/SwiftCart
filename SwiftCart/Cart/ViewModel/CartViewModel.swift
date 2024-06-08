//
//  CartViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 08/06/2024.
//

import Foundation
class CartViewModel {
    
    func addToCart(customerId: Int, lineItem: LineItem){
        CartNetwork.shared.createOrder(customerID: customerId, lineItem: lineItem) { result in
                                       switch result {
                                       case .success(let data):
                                           print("Added address successfully: \(data)")
                                       case .failure(let error):
                                           print("Failed to add address: \(error)")
                                       }
                                   }
    }
    
}
