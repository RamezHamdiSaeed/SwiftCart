//
//  MockCartnetwork.swift
//  SwiftCartTests
//
//  Created by rwan elmtary on 16/06/2024.
//

import Foundation
@testable import SwiftCart

class MockCartNetwork: CartNetwork {
    var createOrderResult: Result<Bool, Error>?
    var fetchDraftOrdersResult: Result<[DraftOrder], Error>?
    var updateOrderResult: Result<Bool, Error>?
    var deleteOrderResult: Result<Bool, Error>?
    var completeDraftOrderResult: Result<Bool, Error>?
    
    var createOrderCalledWith: (customerID: Int, lineItem: LineItemRequest)?
    var fetchDraftOrdersCalled = false
    var updateOrderCalledWith: (orderID: Int, updatedItem: LineItemRequest)?
    var deleteOrderCalledWith: Int?
    var completeDraftOrderCalledWith: Int?
    
    override func createOrder(customerID: Int, lineItem: LineItemRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        createOrderCalledWith = (customerID, lineItem)
        if let result = createOrderResult {
            completion(result)
        }
    }
    
    override func fetchDraftOrders(completion: @escaping (Result<[DraftOrder], Error>) -> Void) {
        fetchDraftOrdersCalled = true
        if let result = fetchDraftOrdersResult {
            completion(result)
        }
    }
    
    override func updateOrder(orderID: Int, updatedItem: LineItemRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        updateOrderCalledWith = (orderID, updatedItem)
        if let result = updateOrderResult {
            completion(result)
        }
    }
    
    override func deleteOrder(orderID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        deleteOrderCalledWith = orderID
        if let result = deleteOrderResult {
            completion(result)
        }
    }
    
    override func completeDraftOrder(orderID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        completeDraftOrderCalledWith = orderID
        if let result = completeDraftOrderResult {
            completion(result)
        }
    }
}

