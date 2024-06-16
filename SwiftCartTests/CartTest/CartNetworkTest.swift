//
//  CartNetworkTest.swift
//  SwiftCartTests
//
//  Created by rwan elmtary on 16/06/2024.
//

import XCTest
@testable import SwiftCart

class CartNetworkTest: XCTestCase {
    
    var cartNetwork: CartNetwork!
    
    override func setUp() {
        super.setUp()
        cartNetwork = CartNetwork.shared
    }
    
    override func tearDown() {
        cartNetwork = nil
        super.tearDown()
    }
    
    func testCreateOrderSuccess() {
        let expectation = self.expectation(description: "CreateOrder")
        let customerID = 12345
        let lineItem = LineItemRequest(variantID: 1, quantity: 2, imageUrl: "http://example.com/image.png")
        
        cartNetwork.createOrder(customerID: customerID, lineItem: lineItem) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Order creation should succeed")
            case .failure(let error):
                XCTFail("Order creation failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchDraftOrdersSuccess() {
        let expectation = self.expectation(description: "FetchDraftOrders")
        
        cartNetwork.fetchDraftOrders { result in
            switch result {
            case .success(let draftOrders):
                XCTAssertNotNil(draftOrders, "Draft orders should not be nil")
            case .failure(let error):
                XCTFail("Fetching draft orders failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUpdateOrderSuccess() {
        let expectation = self.expectation(description: "UpdateOrder")
        let orderID = 12345
        let updatedItem = LineItemRequest(variantID: 1, quantity: 2, imageUrl: "http://example.com/image.png")
        
        cartNetwork.updateOrder(orderID: orderID, updatedItem: updatedItem) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Order update should succeed")
            case .failure(let error):
                XCTFail("Order update failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDeleteOrderSuccess() {
        let expectation = self.expectation(description: "DeleteOrder")
        let orderID = 12345
        
        cartNetwork.deleteOrder(orderID: orderID) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Order deletion should succeed")
            case .failure(let error):
                XCTFail("Order deletion failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCompleteDraftOrderSuccess() {
        let expectation = self.expectation(description: "CompleteDraftOrder")
        let orderID = 12345
        
        cartNetwork.completeDraftOrder(orderID: orderID) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Completing draft order should succeed")
            case .failure(let error):
                XCTFail("Completing draft order failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

