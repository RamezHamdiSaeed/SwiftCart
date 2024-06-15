//
//  CartViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 08/06/2024.
//

import Foundation

class CartViewModel {
    
    var rateClosure : (Double)->Void = {_ in }
    
    func getRate(){
        getPrice() { [weak self] rate in
            self?.rateClosure(rate)
        
        }
    }
    
    var result: [DraftOrder]? {
        didSet {
            print("Result set with \(result?.count ?? 0) items")
            bindResultToViewController?()
        }
    }
       
    var bindResultToViewController: (() -> Void)?
    
    // Method to add a line item to the cart
    func addToCart(customerId: Int, lineItem: LineItemRequest) {
        print("Adding to cart with customerId: \(customerId) and lineItem: \(lineItem)")
        CartNetwork.shared.createOrder(customerID: customerId, lineItem: lineItem) { (result: Result<Bool, Error>) in
            switch result {
            case .success(let success):
                print("Added to cart successfully: \(success)")
            case .failure(let error):
                print("Failed to add to cart: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchFromCart(customerID: Int) {
        print("Fetching draft orders for customerID: \(customerID)")
        CartNetwork.shared.fetchDraftOrders { [weak self] (result: Result<[DraftOrder], Error>) in
            switch result {
            case .success(let draftOrders):
                let filteredDraftOrders = draftOrders.filter { $0.customer?.id == customerID }
                print("Filtered draft orders: \(filteredDraftOrders)")
                print("CartViewModel success: Found \(filteredDraftOrders.count) draft orders")
                self?.result = filteredDraftOrders
            case .failure(let error):
                print("CartViewModel error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteFromCart(draftOrderID: Int) {
           print("Deleting draft order with ID: \(draftOrderID)")
           CartNetwork.shared.deleteOrder(draftOrderID: draftOrderID) { [weak self] (result: Result<Bool, Error>) in
               switch result {
               case .success(let success):
                   print("Deleted from cart successfully: \(success)")
                   self?.result?.removeAll(where: { $0.id == draftOrderID })
                   self?.bindResultToViewController?()
               case .failure(let error):
                   print("Failed to delete from cart: \(error.localizedDescription)")
               }
           }
       }
    
    func updateOrder(customerID: Int, draftOrderID: Int, lineItem: LineItemRequest, completion: @escaping (Bool) -> Void) {
        print("Updating draft order with ID: \(draftOrderID) for customerID: \(customerID) with lineItem: \(lineItem)")
        CartNetwork.shared.updateOrder(customerID: customerID, draftOrderID: draftOrderID, lineItem: lineItem) { (result: Result<Bool, Error>) in
            switch result {
            case .success(let success):
                print("Updated order successfully: \(success)")
                completion(true)
            case .failure(let error):
                print("Failed to update order: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    //static method for testing
//      func addStaticProductToCart(customerId: Int) {
//          let staticLineItem = LineItemRequest(variantID: 46036215628027, quantity: 1)
//          addToCart(customerId: customerId, lineItem: staticLineItem)
//      }
}
