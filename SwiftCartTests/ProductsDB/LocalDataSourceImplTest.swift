//
//  LocalDataSourceImplTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation
import XCTest
import Firebase
@testable import SwiftCart

final class LocalDataSourceImplTest: XCTestCase {
    
    let productTemp = ProductTemp(id: 8624930816251, name: "ASICS TIGER | GEL-LYTE V '30 YEARS OF GEL' PACK", price: 220.00, isFavorite: true, image: "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/343bfbfc1a10a39a528a3d34367669c2.jpg?v=1716705923")
    
    override func setUpWithError() throws {
        LocalDataSourceImpl.shared.getProductsFromFav()?.forEach({
            product in
            LocalDataSourceImpl.shared.deleteProductFromFav(product: product)
        })
        
    }
    
    override func tearDownWithError() throws {
        LocalDataSourceImpl.shared.getProductsFromFav()?.forEach({
            product in
            LocalDataSourceImpl.shared.deleteProductFromFav(product: product)
        })
    }
    
    func  testProductInsertionDB(){
        let expect = expectation(description: "test Product Insertion")
        LocalDataSourceImpl.shared.insertProductToFav(product: productTemp)
        if LocalDataSourceImpl.shared.getProductsFromFav()?.count == 1 && LocalDataSourceImpl.shared.isFav(product: productTemp) {
            XCTAssertTrue(true)
            expect.fulfill()
            
        }
        
        waitForExpectations(timeout: 10)
    }
    
    
    func  testProductRemovalDB(){
        let expect = expectation(description: "test Product Removal")
        LocalDataSourceImpl.shared.insertProductToFav(product: productTemp)
        LocalDataSourceImpl.shared.deleteProductFromFav(product: productTemp)
        let isFavoritesEmpty = !LocalDataSourceImpl.shared.getProductsFromFav()!.isEmpty
        let isProductRemoved = LocalDataSourceImpl.shared.isFav(product: productTemp)
        if  isFavoritesEmpty && isProductRemoved {
            XCTAssertTrue(true)
            expect.fulfill()
            
        }
        waitForExpectations(timeout:10)
    }
    
}
