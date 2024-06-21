//
//  DiscountServiceTesting.swift
//  SwiftCartTests
//
//  Created by rwan elmtary on 21/06/2024.
//

import XCTest
@testable import SwiftCart

class DiscountServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testGetDiscountCodesFailure() throws {
        let expectation = self.expectation(description: "Get Discount Codes Failure")
        
        let invalidDiscountId = "invalid"
        
        DiscountService.getDiscountCodes(discountId: invalidDiscountId) { result in
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
    
//    func testGetPriceRulesFailure() throws {
//        let expectation = self.expectation(description: "Get Price Rules Failure")
//        
//        DiscountService.getPriceRules { result in
//            switch result {
//            case .success:
//                XCTFail("Expected failure, but got success")
//            case .failure(let error):
//                XCTAssertNotNil(error, "Expected an error but got nil")
//            }
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 10, handler: nil)
//    }
//    
//    func testCheckForCouponsFailure() throws {
//        let expectation = self.expectation(description: "Check For Coupons Failure")
//        
//        let invalidDiscountCode = "invalid" 
//        
//        DiscountService.checkForCoupons(discountCode: invalidDiscountCode) { result in
//            switch result {
//            case .success:
//                XCTFail("Expected failure, but got success")
//            case .failure(let error):
//                XCTAssertNotNil(error, "Expected an error but got nil")
//            }
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 10, handler: nil)
//    }
}
