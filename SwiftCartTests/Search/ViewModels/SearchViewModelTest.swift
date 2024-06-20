//
//  SearchViewModelTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 19/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

final class SearchViewModelTest: XCTestCase {
  
    var searchFavoriteProductsViewModel : SearchViewModel?
    
   
    override func setUpWithError() throws {
        
    }
    

    override func tearDownWithError() throws {
    }
    

    func testfetchProducts() throws {
        let expect = expectation(description: "test fetch Products")
        self.searchFavoriteProductsViewModel?.fetchProducts(whenSuccess: {
            XCTAssertTrue(true)
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 20)
    }
    
    
}
