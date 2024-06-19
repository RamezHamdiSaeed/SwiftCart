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
    
       override func setUpWithError() throws {
           signedUpCustomer = SignedUpCustomer(customer: SignedUpCustomerInfo(email: "testCreationAndRetrievingCustomer2000@gmail.com",verifiedEmail: true, state: "enabled"))
       }

       override func tearDownWithError() throws {
           signedUpCustomer = SignedUpCustomer()
       }
       
       func testCreateCustomer() {
           let expect = expectation(description: "test post customer")
           
           self.networkingManager.networkingRequest(path: "/customers.json", queryItems: nil, method: .POST, requestBody: signedUpCustomer,completeBaseURL: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04",networkResponse: { (result: Result<SignedUpCustomerResponse, NetworkError>) in
              switch result {
              case .success(_):
                  XCTAssertTrue(true)
                  expect.fulfill()
              case .failure(_):
                  XCTFail("already created")
                  expect.fulfill()
              }
          })

           waitForExpectations(timeout: 10)
       }
       
       func testGetLoggedInCustomerByEmail() {
           let expect = expectation(description: "test retireve  customer")
           
           self.networkingManager.networkingRequest(path: "/customers/search.json", queryItems: [URLQueryItem(name: "query", value: signedUpCustomer.customer?.email)], method: .GET, requestBody: nil, completeBaseURL: nil, networkResponse: { (result: Result<LoggedInCustomers, NetworkError>) in
               switch result {
               case .success(_):
                   XCTAssertTrue(true)
                   expect.fulfill()
               case .failure(_):
                   XCTFail("accountNotFound")
                   expect.fulfill()
               }
           })

           waitForExpectations(timeout: 10)
       }
    
}
