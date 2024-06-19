//
//  ShopifyAuthNetworkServiceImplTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

final class ShopifyAuthNetworkServiceImplTest: XCTestCase {
    
    let networkingManager = NetworkingManagerImpl()
    
    var signedUpCustomer : SignedUpCustomer = SignedUpCustomer()
    
    func deleteCustomer(whenExecuted:@escaping(()->())){
        self.networkingManager.networkingRequest(path: "/customers/7531109974267.json", queryItems: nil, method: .DELETE, requestBody: nil, completeBaseURL: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04", networkResponse:{ (result: Result<LoggedInCustomers, NetworkError>) in
                whenExecuted()
            
            })
        
    }
       override func setUpWithError() throws {
           signedUpCustomer = SignedUpCustomer(customer: SignedUpCustomerInfo(email: "testCreationAndRetrievingCustomer2000@gmail.com",verifiedEmail: true, state: "enabled"))
           
       }

       override func tearDownWithError() throws {
           signedUpCustomer = SignedUpCustomer()
       }
       
       func testCreateCustomer() {
           let expect = expectation(description: "test post customer")
           
           deleteCustomer(whenExecuted: {
               self.networkingManager.networkingRequest(path: "/customers.json", queryItems: nil, method: .POST, requestBody: self.signedUpCustomer,completeBaseURL: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04",networkResponse: { (result: Result<SignedUpCustomer, NetworkError>) in
                  switch result {
                  case .success(_):
                      XCTAssertTrue(true)
                      expect.fulfill()
                  case .failure(_):
                      XCTFail("already created")
                      expect.fulfill()
                  }
              })

           })
           
         
           waitForExpectations(timeout: 20)
       }
       
       func testGetLoggedInCustomerByEmail() {
           self.signedUpCustomer.customer?.email = "z.z@gmail.com"
           let expect = expectation(description: "test retireve  customer")
           
           self.networkingManager.networkingRequest(path: "/customers.json", queryItems: nil, method: .POST, requestBody: signedUpCustomer,completeBaseURL: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04",networkResponse: { (result: Result<SignedUpCustomerResponse, NetworkError>) in
              switch result {
              case .success(_):
                  self.networkingManager.networkingRequest(path: "/customers/search.json", queryItems: [URLQueryItem(name: "query", value: self.signedUpCustomer.customer?.email)], method: .GET, requestBody: nil, completeBaseURL: nil, networkResponse: { (result: Result<LoggedInCustomers, NetworkError>) in
                      switch result {
                      case .success(_):
                          XCTAssertTrue(true)
                          expect.fulfill()
                      case .failure(_):
                          XCTFail("accountNotFound")
                          expect.fulfill()
                      }
                  })
              case .failure(_):
                  XCTFail("already created")
                  expect.fulfill()
              }
          })
           
           

           waitForExpectations(timeout: 10)
       }
    
}
