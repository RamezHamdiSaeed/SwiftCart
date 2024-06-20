//
//  FavoriteViewModelTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 19/06/2024.
//

import Foundation

import XCTest
@testable import SwiftCart

final class FavoriteViewModelTest: XCTestCase {
  
    var searchFavoriteProductsViewModel : FavoriteViewModel?
    
    let productTemp = ProductTemp(id: 8624930816251, name: "ASICS TIGER | GEL-LYTE V '30 YEARS OF GEL' PACK", price: 220.00, isFavorite: true, image: "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/343bfbfc1a10a39a528a3d34367669c2.jpg?v=1716705923")
   
    override func setUpWithError() throws {
        
        LocalDataSourceImpl.shared.getProductsFromFav()?.forEach({
            product in
            LocalDataSourceImpl.shared.deleteProductFromFav(product: product)
        })
    }
    

    override func tearDownWithError() throws {
        searchFavoriteProductsViewModel = nil
        LocalDataSourceImpl.shared.getProductsFromFav()?.forEach({
            product in
            LocalDataSourceImpl.shared.deleteProductFromFav(product: product)
        })
    }
    

    func testProductInsertionDB() throws {
        let expect = expectation(description: "test Product Insertion")
//        LocalDataSourceImpl.shared.insertProductToFav(product: productTemp)
        self.searchFavoriteProductsViewModel?.insertProductToFavDB(product: self.productTemp)
        if LocalDataSourceImpl.shared.getProductsFromFav()?.count == 1 && LocalDataSourceImpl.shared.isFav(product: productTemp) {
            XCTAssertTrue(true)
            expect.fulfill()
            
        }
        
        waitForExpectations(timeout: 20)
    }
    
    func testProductRemovalDB() throws {
        let expect = expectation(description: "test Product Removal")
        self.searchFavoriteProductsViewModel?.insertProductToFavDB(product: self.productTemp)
        self.searchFavoriteProductsViewModel?.deleteProductFromFav(product: productTemp)
        let isFavoritesEmpty = !LocalDataSourceImpl.shared.getProductsFromFav()!.isEmpty
        let isProductRemoved = LocalDataSourceImpl.shared.isFav(product: productTemp)
        if  isFavoritesEmpty && isProductRemoved {
            XCTAssertTrue(true)
            expect.fulfill()
            
        }
        waitForExpectations(timeout:10)
    }
    
    
}
