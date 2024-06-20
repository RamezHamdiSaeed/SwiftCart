//
//  InputValidatorTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 20/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart
class InputValidatorTest: XCTestCase {

    func testValidEmails() {
            XCTAssertTrue(InputValidator.isValidEmail(email: "test@example.com"))
            XCTAssertTrue(InputValidator.isValidEmail(email: "user.name+tag+sorting@example.com"))
            XCTAssertTrue(InputValidator.isValidEmail(email: "x@example.com"))
            XCTAssertTrue(InputValidator.isValidEmail(email: "example-indeed@strange-example.com"))
            XCTAssertTrue(InputValidator.isValidEmail(email: "example@s.solutions"))
        }

        func testInvalidEmails() {
            XCTAssertFalse(InputValidator.isValidEmail(email: "plainaddress"))
            XCTAssertFalse(InputValidator.isValidEmail(email: "@missing-username.com"))
            XCTAssertFalse(InputValidator.isValidEmail(email: "username@.com"))
            XCTAssertFalse(InputValidator.isValidEmail(email: "username@.com."))
            XCTAssertFalse(InputValidator.isValidEmail(email: "admin@mailserver1"))
            XCTAssertFalse(InputValidator.isValidEmail(email: "user@[IPv6:2001:db8::1]"))
        }

        func testValidPasswords() {
            XCTAssertTrue(InputValidator.isValidPassword(password: "Password1!"))
            XCTAssertTrue(InputValidator.isValidPassword(password: "Aa1@aaaa"))
            XCTAssertTrue(InputValidator.isValidPassword(password: "StrongPass1@"))
            XCTAssertTrue(InputValidator.isValidPassword(password: "Valid123$"))
        }

        func testInvalidPasswords() {
            XCTAssertFalse(InputValidator.isValidPassword(password: "password"))
            XCTAssertFalse(InputValidator.isValidPassword(password: "PASSWORD"))
            XCTAssertFalse(InputValidator.isValidPassword(password: "12345678"))
            XCTAssertFalse(InputValidator.isValidPassword(password: "pass1!"))
            XCTAssertFalse(InputValidator.isValidPassword(password: "NoSpecial1"))
            XCTAssertFalse(InputValidator.isValidPassword(password: "sh0rt!"))
        }
}
