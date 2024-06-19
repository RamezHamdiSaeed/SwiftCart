//
//  FavoriteSyncTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation
import XCTest
import Firebase
@testable import SwiftCart

final class FavoriteSyncTest: XCTestCase {
    
    override func setUpWithError() throws {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    override func tearDownWithError() throws {
    }
    
       func testUploadProducts() {
           
           let expect = expectation(description: "test Upload Products")
           
           FavoriteSync.uploadProducts(for: "test@gmail.com", products: [ProductTemp(id: 8624930816251, name: "ASICS TIGER | GEL-LYTE V '30 YEARS OF GEL' PACK", price: 220.00, isFavorite: true, image: "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/343bfbfc1a10a39a528a3d34367669c2.jpg?v=1716705923")],whenSuccess: {
               XCTAssertTrue(true)
               expect.fulfill()
           })
           
           waitForExpectations(timeout: 20)
       }
    
    func  testFetchProducts(){
        let expect = expectation(description: "test Fetch Products")
        FavoriteSync.fetchProducts(for: "test@gmail.com", completion: {
            products in
            XCTAssertTrue(true)
            expect.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
 
}
