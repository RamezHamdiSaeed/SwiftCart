//
//  FirebaseAuthImpl.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//
import Foundation
import XCTest
import Firebase

@testable import SwiftCart

final class FirebaseAuthImplTest: XCTestCase {
  
    let firebaseAuthImplTest = MockFirebaseAuthImpl()
    
    var userEmail: String?
    var userPassword: String?

    override func setUpWithError() throws {
        userEmail = "test@gmail.com"
        userPassword = "1232qwewQ!MaC"
        // Ensure no user is logged in before each test
//        try Auth.auth().signOut()
        firebaseAuthImplTest.deleteUserByEmail(email: userEmail!, password: userPassword!)
    }

    override func tearDownWithError() throws {
        userEmail = nil
        userPassword = nil
    }
    

    func testUnRegisteredUser() throws {
        let expect = expectation(description: "Unregistered User Login")
        
        firebaseAuthImplTest.logIn(email: userEmail!, password: userPassword!, whenSuccess: {
            XCTFail("Login should not succeed for unregistered user")
            expect.fulfill()
        })
            XCTAssertTrue(true)
            expect.fulfill()
        
        
        waitForExpectations(timeout: 10)
    }
    
    func testRegisteredUser() throws {
        let signUpExpectation = expectation(description: "Register Account")
        
        firebaseAuthImplTest.signUp(email: userEmail!, password: userPassword!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            signUpExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
        let logInExpectation = expectation(description: "Registered User Login")

        firebaseAuthImplTest.logIn(email: userEmail!, password: userPassword!, whenSuccess: {
            XCTAssertTrue(true, "Login should succeed for registered user")
            logInExpectation.fulfill()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            logInExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
}
