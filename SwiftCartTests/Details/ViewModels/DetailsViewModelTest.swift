//
//  DetailsViewModelTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 19/06/2024.
//

import Foundation
import XCTest

@testable import SwiftCart

final class DetailsViewModelTest: XCTestCase {
  
//    let firebaseAuthImplTest = MockFirebaseAuthImpl()
    var detailsViewModel:DetailsViewModel?
    
   
    override func setUpWithError() throws {
        detailsViewModel = DetailsViewModel(detailsnetworkService: DetailsNetworkService(networkingManager: NetworkingManagerImpl()))
    }
    

    override func tearDownWithError() throws {
        self.detailsViewModel = nil
    }
    

    func testFetchProductDetails() throws {
        let expect = expectation(description: "test Fetch Product Details")
        self.detailsViewModel?.getProductDetails(productID: "8624930816251", whenSuccess: {
            XCTAssertTrue(true)
            expect.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
  
    
}
