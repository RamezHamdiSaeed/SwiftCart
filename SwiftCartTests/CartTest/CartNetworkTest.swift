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
    
    func testUpdateOrder() {
        let createExpectation = expectation(description: "CreateOrderForUpdate")
        
        cartNetwork.createOrder(customerID: testCustomerID, lineItem: testLineItem) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    XCTAssertTrue(success, "Order creation should succeed")
                    
                    self.cartNetwork.fetchDraftOrders { fetchResult in
                        DispatchQueue.main.async {
                            switch fetchResult {
                            case .success(let draftOrders):
                                guard let draftOrder = draftOrders.first else {
                                    XCTFail("No draft orders found")
                                    createExpectation.fulfill()
                                    return
                                }
                                
                                self.createdDraftOrderID = draftOrder.id
                                
                                let updateExpectation = self.expectation(description: "UpdateOrder")
                                
                                let updatedLineItem = LineItemRequest(variantID: self.validVariantID, quantity: 3, imageUrl: "https://images.app.goo.gl/2AigmaKAjZHnV5rp7")
                                
                                self.cartNetwork.updateOrder(customerID: self.testCustomerID, draftOrderID: draftOrder.id ?? 0, lineItem: updatedLineItem) { updateResult in
                                    DispatchQueue.main.async {
                                        switch updateResult {
                                        case .success(let success):
                                            XCTAssertTrue(success, "Order update should succeed")
                                        case .failure(let error):
                                            XCTFail("Order update failed: \(error.localizedDescription)")
                                        }
                                        updateExpectation.fulfill()
                                    }
                                }
                                
                            case .failure(let error):
                                XCTFail("Fetching draft orders failed: \(error.localizedDescription)")
                            }
                            createExpectation.fulfill()
                        }
                    }
                    
                case .failure(let error):
                    XCTFail("Order creation failed: \(error.localizedDescription)")
                    createExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }


    func testDeleteOrder() {
        let createExpectation = self.expectation(description: "CreateOrderForDeletion")
        
        cartNetwork.createOrder(customerID: testCustomerID, lineItem: testLineItem) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Order creation should succeed")
                
                self.cartNetwork.fetchDraftOrders { fetchResult in
                    switch fetchResult {
                    case .success(let draftOrders):
                        guard let draftOrder = draftOrders.first else {
                            XCTFail("No draft orders found")
                            createExpectation.fulfill()
                            return
                        }
                        
                        let deleteExpectation = self.expectation(description: "DeleteOrder")
                        
                        self.cartNetwork.deleteOrder(draftOrderID: draftOrder.id ?? 0) { deleteResult in
                            switch deleteResult {
                            case .success(let success):
                                XCTAssertTrue(success, "Order deletion should succeed")
                            case .failure(let error):
                                XCTFail("Order deletion failed: \(error.localizedDescription)")
                            }
                            deleteExpectation.fulfill()
                        }
                        
                        self.waitForExpectations(timeout: 10, handler: nil)
                        
                    case .failure(let error):
                        XCTFail("Fetching draft orders failed: \(error.localizedDescription)")
                    }
                    createExpectation.fulfill()
                }
                
            case .failure(let error):
                XCTFail("Order creation failed: \(error.localizedDescription)")
                createExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testCompleteDraftOrder() {
        let createExpectation = self.expectation(description: "CreateOrderForCompletion")
        
        cartNetwork.createOrder(customerID: testCustomerID, lineItem: testLineItem) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Order creation should succeed")
                
                self.cartNetwork.fetchDraftOrders { fetchResult in
                    switch fetchResult {
                    case .success(let draftOrders):
                        guard let draftOrder = draftOrders.first else {
                            XCTFail("No draft orders found")
                            createExpectation.fulfill()
                            return
                        }
                        
                        let completeExpectation = self.expectation(description: "CompleteDraftOrder")
                        
                        self.cartNetwork.completeDraftOrder(draftOrderID: draftOrder.id ?? 0) { completeResult in
                            switch completeResult {
                            case .success(let success):
                                XCTAssertTrue(success, "Order completion should succeed")
                            case .failure(let error):
                                XCTFail("Order completion failed: \(error.localizedDescription)")
                            }
                            completeExpectation.fulfill()
                        }
                        
                        self.waitForExpectations(timeout: 10, handler: nil)
                        
                    case .failure(let error):
                        XCTFail("Fetching draft orders failed: \(error.localizedDescription)")
                    }
                    createExpectation.fulfill()
                }
                
            case .failure(let error):
                XCTFail("Order creation failed: \(error.localizedDescription)")
                createExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testDeleteDraftOrder() {
        let createExpectation = self.expectation(description: "CreateOrderForDraftDeletion")
        
        cartNetwork.createOrder(customerID: testCustomerID, lineItem: testLineItem) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Order creation should succeed")
                
                self.cartNetwork.fetchDraftOrders { fetchResult in
                    switch fetchResult {
                    case .success(let draftOrders):
                        guard let draftOrder = draftOrders.first else {
                            XCTFail("No draft orders found")
                            createExpectation.fulfill()
                            return
                        }
                        
                        let deleteDraftExpectation = self.expectation(description: "DeleteDraftOrder")
                        
                        self.cartNetwork.deleteDraftOrder(draftOrderID: draftOrder.id ?? 0) { deleteResult in
                            switch deleteResult {
                            case .success(let success):
                                XCTAssertTrue(success, "Draft order deletion should succeed")
                            case .failure(let error):
                                XCTFail("Draft order deletion failed: \(error.localizedDescription)")
                            }
                            deleteDraftExpectation.fulfill()
                        }
                        
                        self.waitForExpectations(timeout: 10, handler: nil)
                        
                    case .failure(let error):
                        XCTFail("Fetching draft orders failed: \(error.localizedDescription)")
                    }
                    createExpectation.fulfill()
                }
                
            case .failure(let error):
                XCTFail("Order creation failed: \(error.localizedDescription)")
                createExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
}
