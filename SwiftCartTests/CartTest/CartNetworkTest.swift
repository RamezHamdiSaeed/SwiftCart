//
//  CartNetworkTest.swift
//  SwiftCartTests
//
//  Created by rwan elmtary on 20/06/2024.
//
import XCTest
@testable import SwiftCart

class CartNetworkTest: XCTestCase {
    
    let cartNetwork = CartNetwork()
    let testCustomerID = 7504624025851
    let validVariantID = 46036216611067
    var testLineItem: LineItemRequest!
    var createdDraftOrderID: Int?
    
    override func setUp() {
        super.setUp()
        testLineItem = LineItemRequest(variantID: validVariantID, quantity: 2, imageUrl: "https://images.app.goo.gl/2AigmaKAjZHnV5rp7")
    }
    
    override func tearDown() {
        testLineItem = nil
        if let draftOrderID = createdDraftOrderID {
            cartNetwork.deleteDraftOrder(draftOrderID: draftOrderID) { _ in }
        }
        super.tearDown()
    }
    
    func testCreateOrder() {
        let expectation = self.expectation(description: "CreateOrder")
        
        cartNetwork.createOrder(customerID: testCustomerID, lineItem: testLineItem) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Order creation should succeed")
            case .failure(let error):
                XCTFail("Order creation failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchDraftOrders() {
        let expectation = self.expectation(description: "FetchDraftOrders")
        
        cartNetwork.fetchDraftOrders { result in
            switch result {
            case .success(let draftOrders):
                XCTAssertNotNil(draftOrders, "Draft orders should not be nil")
                XCTAssertGreaterThan(draftOrders.count, 0, "Draft orders should not be empty")
            case .failure(let error):
                XCTFail("Fetching draft orders failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
        
        func testUpdateOrderFailure() throws {
            let expectation = self.expectation(description: "Update Order Failure")
            
            let invalidCustomerID = -1
            let invalidDraftOrderID = -1
            let lineItem = LineItemRequest(variantID: 0, quantity: 0, imageUrl: "https://images.app.goo.gl/2AigmaKAjZHnV5rp7")
            
            cartNetwork.updateOrder(customerID: invalidCustomerID, draftOrderID: invalidDraftOrderID, lineItem: lineItem) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    XCTAssertNotNil(error, "Expected an error but got nil")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
        
        func testDeleteOrderFailure() throws {
            let expectation = self.expectation(description: "Delete Order Failure")
            
            let invalidDraftOrderID = -1
            
            cartNetwork.deleteOrder(draftOrderID: invalidDraftOrderID) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    XCTAssertNotNil(error, "Expected an error but got nil")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    }
