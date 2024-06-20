//
//  OnBoardingManagerTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 20/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

class OnBoardingManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Reset the UserDefaults to ensure a clean state before each test
        UserDefaults.standard.removeObject(forKey: "isNewUser")
    }

    override func tearDown() {
        // Reset the UserDefaults to ensure clean state after each test
        UserDefaults.standard.removeObject(forKey: "isNewUser")
        super.tearDown()
    }

    func testIsNewUserInitial() {
        let manager = OnBoardingManager.shared
        XCTAssertTrue(manager.isNewuser(), "The user should be new initially")
    }

    func testSetIsNotNewUser() {
        let manager = OnBoardingManager.shared
        manager.setIsNotNewUser()
        XCTAssertFalse(manager.isNewuser(), "The user should not be new after setIsNotNewUser is called")
    }

    func testIsNewUserAfterSet() {
        let manager = OnBoardingManager.shared
        manager.setIsNotNewUser()
        XCTAssertFalse(manager.isNewuser(), "The user should not be new after setIsNotNewUser is called")
        UserDefaults.standard.removeObject(forKey: "isNewUser")
        XCTAssertTrue(manager.isNewuser(), "The user should be new after resetting UserDefaults")
    }
}

