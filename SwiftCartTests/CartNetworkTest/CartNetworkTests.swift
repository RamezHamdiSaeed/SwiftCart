//
//  CartNetworkTests.swift
//  SwiftCartTests
//
//  Created by rwan elmtary on 16/06/2024.
//

import XCTest
@testable import YourProjectName

class CartNetworkTests: XCTestCase {
    
    var cartNetwork: CartNetwork!
    var cart: Cart!

    override func setUpWithError() throws {
        try super.setUpWithError()
        cartNetwork = CartNetwork()
        cart = Cart(items: [CartItem(id: 1, name: "Item1", quantity: 1)])
    }

    override func tearDownWithError() throws {
        cartNetwork = nil
        cart = nil
        try super.tearDownWithError()
    }

    func testAddToCartSuccess() {
        let expectation = self.expectation(description: "Add to cart succeeds")
        
        cartNetwork.addToCart(cart: cart) { result in
            switch result {
            case .success(let updatedCart):
                XCTAssertNotNil(updatedCart)
                XCTAssertEqual(updatedCart.items.count, self.cart.items.count)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testAddToCartFailure() {
        let expectation = self.expectation(description: "Add to cart fails due to encoding error")

        cart = Cart(items: [CartItem(id: -1, name: "Item1", quantity: 1)])  // invalid id

        cartNetwork.addToCart(cart: cart) { result in
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
        
        cartNetwork.removeFromCart(cart: cart) { result in
            switch result {
            case .success(let updatedCart):
                XCTAssertNotNil(updatedCart)
                XCTAssertEqual(updatedCart.items.count, self.cart.items.count)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRemoveFromCartFailure() {
        let expectation = self.expectation(description: "Remove from cart fails due to encoding error")

        cart = Cart(items: [CartItem(id: -1, name: "Item1", quantity: 1)])  // invalid id

        cartNetwork.removeFromCart(cart: cart) { result in
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
