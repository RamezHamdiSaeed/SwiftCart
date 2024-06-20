//
//  DetailsNetworkServiceTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

final class DetailsNetworkServiceTest: XCTestCase {
    
    let detailsNetworkService = DetailsNetworkService(networkingManager: MockNetworkingManager())
       override func setUpWithError() throws {
       }

       override func tearDownWithError() throws {
       }
       
       func testFetchProductDetails() {
           let expect = expectation(description: "test Fetch Product Details test")
           self.detailsNetworkService.fetchProductDetails(id: "8624930816251", productsDetailsResult: {
               
               productDetails in
               XCTAssertTrue(true)
               expect.fulfill()
               
           })
           
           waitForExpectations(timeout: 10)
       }
 
}
