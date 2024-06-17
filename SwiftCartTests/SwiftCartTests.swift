//
//  SwiftCartTests.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 23/05/2024.
//

import XCTest
@testable import SwiftCart

final class SwiftCartTests: XCTestCase {
    
    var mockNetworkServices : MockNetworkServices!

    override func setUpWithError() throws {
        mockNetworkServices = MockNetworkServices(shouldReturnError: false)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testFetchBrands() {
        let expect = expectation(description: "test Fetch Brands from network")
        
        NetworkServicesImpl.fetchBrands { resRes in
            switch resRes {
            case .success(data: let data):
                XCTAssertNotNil(data)
                expect.fulfill()
            case .failure(error: let error):
                XCTFail("Failed")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    
    func testFetchProducts() {
        let expect = expectation(description: "Fetch Products from network")
        
        NetworkServicesImpl.fetchProducts(collectionId: "422258540795") { result in
            switch result {
            case .success(let data):
               // XCTAssertNotNil(data)
                XCTAssertTrue(data.products.count != 0)

                expect.fulfill()
            case .failure(let error):
               XCTFail("Failed with error: \(error)")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

    func testFetchProductsForSubCategory() {
        let expect = expectation(description: "Fetch Products for SubCategory from network")
        
        NetworkServicesImpl.fetchProductsForSubCategory(productType: "Shoes") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expect.fulfill()
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

    func testFetchOrders() {
        let expect = expectation(description: "Fetch Orders from network")
        
        NetworkServicesImpl.fetchOrders(customerId: "7495574716667") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertTrue(data.orders?.count != 0)
                expect.fulfill()
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchMockBrands() {
        let expect = expectation(description: "Fetch Mock Brands from mock service")
        
        mockNetworkServices.fetchBrands { resRes in
            switch resRes {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(data.smartCollections.count, 1)
                XCTAssertEqual(data.smartCollections.first?.title, "ADIDAS")
                expect.fulfill()
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
}
