//
//  CartViewModelTests.swift
//  SwiftCartTests
//
//  Created by rwan elmtary on 16/06/2024.
//

import XCTest
@testable import SwiftCart

class CartViewModelTests: XCTestCase {
    
    var viewModel: CartViewModel!
    var mockNetwork: MockCartNetwork!
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockCartNetwork()
        viewModel = CartViewModel(cartNetwork: mockNetwork)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetwork = nil
        super.tearDown()
    }
    
    func testAddToCartSuccess() {
        let customerID = 12345
        let lineItem = LineItemRequest(variantID: 1, quantity: 2, imageUrl: "https://images.app.goo.gl/2AigmaKAjZHnV5rp7")
        
        mockNetwork.createOrderResult = .success(true)
        
        let expectation = self.expectation(description: "AddToCart")
        
        viewModel.addToCart(customerId: customerID, lineItem: lineItem)
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.mockNetwork.createOrderCalledWith?.customerID, customerID)
            XCTAssertEqual(self.mockNetwork.createOrderCalledWith?.lineItem.variantID, lineItem.variantID)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchDraftOrdersSuccess() {
        let draftOrders = [DraftOrder(orderID: 1, customerID: 123, lineItems: [])]
        mockNetwork.fetchDraftOrdersResult = .success(draftOrders)
        
        let expectation = self.expectation(description: "FetchDraftOrders")
        
        viewModel.fetchFromCart()
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockNetwork.fetchDraftOrdersCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUpdateOrderSuccess() {
        let orderID = 12345
        let updatedItem = LineItemRequest(variantID: 1, quantity: 2, imageUrl: "https://images.app.goo.gl/2AigmaKAjZHnV5rp7")
        
        mockNetwork.updateOrderResult = .success(true)
        
        let expectation = self.expectation(description: "UpdateOrder")
        
        viewModel.updateOrder(orderID: orderID, updatedItem: updatedItem)
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.mockNetwork.updateOrderCalledWith?.orderID, orderID)
            XCTAssertEqual(self.mockNetwork.updateOrderCalledWith?.updatedItem.variantID, updatedItem.variantID)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDeleteOrderSuccess() {
        let orderID = 12345
        
        mockNetwork.deleteOrderResult = .success(true)
        
        let expectation = self.expectation(description: "DeleteOrder")
        
        viewModel.deleteDraftOrders(orderID: orderID)
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.mockNetwork.deleteOrderCalledWith, orderID)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCompleteDraftOrderSuccess() {
        let orderID = 12345
        
        mockNetwork.completeDraftOrderResult = .success(true)
        
        let expectation = self.expectation(description: "CompleteDraftOrder")
        
        viewModel.completeDraftOrders(orderID: orderID)
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.mockNetwork.completeDraftOrderCalledWith, orderID)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

