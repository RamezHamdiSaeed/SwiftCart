//
//  UserSessionManagerTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 20/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

class UserSessionManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Reset the UserDefaults to ensure a clean state before each test
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userAddress")
        
        // Reset the User class properties
        User.id = 0
        User.email = nil
        User.Address = nil
    }

    override func tearDown() {
        // Reset the UserDefaults to ensure clean state after each test
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userAddress")
        
        // Reset the User class properties
        User.id = 0
        User.email = nil
        User.Address = nil
        
        super.tearDown()
    }

    func testIsLoggedInUserInitial() {
        let manager = UserSessionManager.shared
        XCTAssertFalse(manager.isLoggedInuser(), "The user should not be logged in initially")
    }

    func testSetIsNotSignedOutUser() {
        let manager = UserSessionManager.shared
        User.id = 123
        User.email = "test@example.com"
        User.Address = "123 Main St"
        manager.setIsNotSignedOutUser()
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: "userID"), 123)
        XCTAssertEqual(UserDefaults.standard.string(forKey: "userEmail"), "test@example.com")
        XCTAssertEqual(UserDefaults.standard.string(forKey: "userAddress"), "123 Main St")
    }

    func testIsLoggedInUserAfterSetting() {
        let manager = UserSessionManager.shared
        User.id = 123
        User.email = "test@example.com"
        User.Address = "123 Main St"
        manager.setIsNotSignedOutUser()
        
        XCTAssertTrue(manager.isLoggedInuser(), "The user should be logged in after setting user details")
        XCTAssertEqual(User.id, 123)
        XCTAssertEqual(User.email, "test@example.com")
        XCTAssertEqual(User.Address, "123 Main St")
    }

    func testSetIsSignedOutUser() {
        let manager = UserSessionManager.shared
        User.id = 123
        User.email = "test@example.com"
        User.Address = "123 Main St"
        manager.setIsNotSignedOutUser()
        
        manager.setIsSignedOutUser()
        
        XCTAssertNil(UserDefaults.standard.string(forKey: "userID"))
        XCTAssertNil(UserDefaults.standard.string(forKey: "userEmail"))
        XCTAssertNil(UserDefaults.standard.string(forKey: "userAddress"))
        
        XCTAssertFalse(manager.isLoggedInuser(), "The user should not be logged in after signing out")
    }
}
