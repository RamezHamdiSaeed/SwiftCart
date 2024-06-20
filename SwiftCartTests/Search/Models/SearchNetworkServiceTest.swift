//
//  SearchNetworkService.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

final class SearchNetworkServiceTest: XCTestCase {
    
    let searchNetworkService = SearchNetworkService(networkingManager: MockNetworkingManager())
    
       override func setUpWithError() throws {
       }

       override func tearDownWithError() throws {
       }
       
       func testFetchProducts() {
           let expect = expectation(description: "test Fetch Products test")
           searchNetworkService.fetchProducts(fetchedProducts: {
               products in
               XCTAssertTrue(!products.isEmpty)
               expect.fulfill()
           })
           waitForExpectations(timeout: 10)
       }
 
}
