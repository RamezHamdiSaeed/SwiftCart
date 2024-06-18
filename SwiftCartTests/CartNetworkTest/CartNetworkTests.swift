//
//  CartNetworkTests.swift
//  SwiftCartTests
//
//  Created by rwan elmtary on 16/06/2024.
//

import XCTest
@testable import SwiftCart

class CartNetworkTests: XCTestCase {
    
    var cartNetwork: CartNetwork!
    var cart: Cart!
    var testCustomerID: Int!
    var testLineItem: LineItemRequest!

    override func setUpWithError() throws {
        try super.setUpWithError()
        cartNetwork = CartNetwork()
        cart = Cart(items: [CartItem(id: 1, name: "Item1", quantity: 1)])
        testCustomerID = 12345
        testLineItem = LineItemRequest(variantID: 123, quantity: 1)
    }

    override func tearDownWithError() throws {
        cartNetwork = nil
        cart = nil
        testCustomerID = nil
        testLineItem = nil
        try super.tearDownWithError()
    }

    func testAddToCartSuccess() {
        let expectation = self.expectation(description: "Add to cart succeeds")
        
        cartNetwork.createOrder(customerID: testCustomerID, lineItem: testLineItem) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testAddToCartFailure() {
        let expectation = self.expectation(description: "Add to cart fails due to invalid line item")

        let invalidLineItem = LineItemRequest(variantID: -1, quantity: 1)  

        cartNetwork.createOrder(customerID: testCustomerID, lineItem: invalidLineItem) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRemoveFromCartSuccess() {
        let expectation = self.expectation(description: "Remove from cart succeeds")
        
        cartNetwork.deleteDraftOrder(draftOrderID: 12345) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRemoveFromCartFailure() {
        let expectation = self.expectation(description: "Remove from cart fails due to invalid order ID")

        cartNetwork.deleteDraftOrder(draftOrderID: -1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
