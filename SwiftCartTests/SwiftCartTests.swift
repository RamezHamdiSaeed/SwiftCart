//
//  SwiftCartTests.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 23/05/2024.
//

import XCTest
@testable import SwiftCart

final class SwiftCartTests: XCTestCase {
    var productsviewModel: ProductsViewModel!
    var homeViewModel: HomeViewModel!
    var mockNetworkServices : MockNetworkServices!
    var networkServices : NetworkServices!
    var categoryViewModel : CategoriesViewModel!


    override func setUpWithError() throws {
        mockNetworkServices = MockNetworkServices(shouldReturnError: false)
        productsviewModel = ProductsViewModel()
        networkServices = NetworkServicesImpl()
        homeViewModel = HomeViewModel(networkService: NetworkServicesImpl())
        categoryViewModel = CategoriesViewModelImp(networkService: NetworkServicesImpl())
    }

    override func tearDownWithError() throws {
        mockNetworkServices = nil
        productsviewModel = nil
        networkServices = nil
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }


    func testFetchBrands() {
        let expect = expectation(description: "test Fetch Brands from network")
        
        networkServices.fetchBrands { resRes in
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
    
    


    func testFetchProductsForSubCategory() {
        let expect = expectation(description: "Fetch Products for SubCategory from network")
        
        networkServices.fetchProductsForSubCategory(productType: "Shoes") { result in
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
        
        networkServices.fetchOrders(customerId: "7495574716667") { result in
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
    
    func testFetchingProducts() {
        let expect = expectation(description: "Fetch Products from network")
        networkServices.fetchProducts(collectionId: "422258540795"){
            result in
               switch result {
               case .success(let data):
                   XCTAssertNotNil(data)
                   XCTAssertTrue(data.products.count != 0)

                   expect.fulfill()
               case .failure(let error):
                  XCTFail("Failed with error")
                   expect.fulfill()
               }
           }
           waitForExpectations(timeout: 5)

    }
    
    func testFetchMockBrands() {
      //  let expect = expectation(description: "Fetch Mock Brands from mock service")
        
        mockNetworkServices.fetchBrands { resRes in
            switch resRes {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(data.smartCollections.count, 1)
                XCTAssertEqual(data.smartCollections.first?.title, "ADIDAS")
       //         expect.fulfill()
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
       //         expect.fulfill()
            }
        }
       // waitForExpectations(timeout: 5)
    }
    func testFetchMockProdcts() {
        
        mockNetworkServices.fetchProducts(collectionId: "422258540795" ){ resRes in
            switch resRes {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertNotNil(data.products.count != 0)
                XCTAssertEqual(data.products.first?.title, "ADIDAS | CLASSIC BACKPACK")
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
            }
        }
    }
    func testFetchMockOrders() {
        mockNetworkServices.fetchOrders(customerId: "7495574716667" ){ resRes in
            switch resRes {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertNotNil(data.orders?.count != 0)
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
            }
        }
    }
    
    

    
    func testGetProductsSuccess() {
         let expect = expectation(description: "fetch products success")

         productsviewModel.productsClosure = { products in
               XCTAssertNotNil(products)
             expect.fulfill()
         }

         productsviewModel.getProducts(collectionId: 123)
         waitForExpectations(timeout: 5)
     }
  

    func testGetProductsFailure() {
        let expect = expectation(description: "fetch products failure")

         productsviewModel.productsClosure = { products in
             XCTFail("Expected failure, but got success")
         }
         productsviewModel.getProducts(collectionId: 200)

         DispatchQueue.main.asyncAfter(deadline: .now() ) {
             expect.fulfill()
         }

         waitForExpectations(timeout: 5, handler: nil)
    }
   
    
    func testGetBrandsSuccess() {
        let expectation = self.expectation(description: "Brands closure called")
        homeViewModel.brandsClosure = { brands in
            XCTAssertNotNil(brands.count != nil)
            expectation.fulfill()
        }
        
        homeViewModel.getBrands()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetBrandsFailure() {
        // Arrange
        mockNetworkServices.shouldReturnError = true
        homeViewModel.brandsClosure = { _ in
            XCTFail("Brands closure should not be called on error")
        }
        homeViewModel.getBrands()
        
    }
    
    func testGetProductsSuccessCategoryViewModel() {
          // Arrange
          let expectation = self.expectation(description: "Products closure called")
        categoryViewModel.productsClosure = { products in
              XCTAssertNotNil(products.count != 0)
              expectation.fulfill()
          }
          
        categoryViewModel.getProducts(collectionId: "422258901243")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
  
        waitForExpectations(timeout: 5, handler: nil)
      }
      
      func testGetProductsFailureCategoryViewModel() {
          mockNetworkServices.shouldReturnError = true
          categoryViewModel.productsClosure = { _ in
            //  XCTFail("Products closure should not be called on error")
          }
          categoryViewModel.getProducts(collectionId: "200")
          
      }
      
      func testGetRateSuccessCategoryViewModel() {
          let expectation = self.expectation(description: "Rate closure called")
          categoryViewModel.rateClosure = { rate in
              XCTAssertNotNil(rate != nil)

              expectation.fulfill()
          }
          
          // Act
          categoryViewModel.getRate()
          
          // Assert
          waitForExpectations(timeout: 1, handler: nil)
      }
    
}
