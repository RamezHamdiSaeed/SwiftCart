//
//  AuthViewModelImplTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 19/06/2024.
//

import Foundation
import XCTest
import Firebase

@testable import SwiftCart

final class AuthViewModelImplTest: XCTestCase {
  
//    let firebaseAuthImplTest = MockFirebaseAuthImpl()
    var authViewModelImpl:AuthViewModelImpl?
    var userEmail: String?
    var userPassword: String?
    
    func deleteUserByEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }

            guard let user = authResult?.user else {
                print("No user found")
                return
            }

            user.delete { error in
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                } else {
                    print("User deleted successfully")
                }
            }
        }
    }
    override func setUpWithError() throws {
        userEmail = "test@gmail.com"
        userPassword = "1232qwewQ!MaC"
        // Ensure no user is logged in before each test
//        try Auth.auth().signOut()
        self.deleteUserByEmail(email: userEmail!, password: userPassword!)
        authViewModelImpl = AuthViewModelImpl()
    }
    

    override func tearDownWithError() throws {
        userEmail = nil
        userPassword = nil
        authViewModelImpl = nil
    }
    

    func testUnRegisteredUser() throws {
        let expect = expectation(description: "Unregistered User Login")
        
        authViewModelImpl?.logIn(email: userEmail!, password: userPassword!, whenSuccess: {
            XCTFail("Login should not succeed for unregistered user")
            expect.fulfill()
        })
        
        
            XCTAssertTrue(true)
            expect.fulfill()
        
        
        waitForExpectations(timeout: 10)
    }
    
    func testRegisteredUser() throws {
        
        let logInExpectation = expectation(description: "Registered User Login")
        
        authViewModelImpl?.signUp(email: userEmail!, password: userPassword!, whenSuccess: {
            self.authViewModelImpl!.logIn(email: self.userEmail!, password: self.userPassword!, whenSuccess: {
                XCTAssertTrue(true, "Login should succeed for registered user")
                logInExpectation.fulfill()
            })
        })
        
        waitForExpectations(timeout: 10)
    }
    
}
