//
//  FirebaseAuthImpl.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation
import Firebase
import XCTest
@testable import SwiftCart

class MockFirebaseAuthImpl : FirebaseAuth{

    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    func deleteUserAccount(completion: @escaping (Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(nil)
            return
        }

        user.delete { error in
            completion(error)
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Registration failed with error: \(error.localizedDescription)")
                // Handle error appropriately (e.g., show an alert)
            } else {
                print("User registered successfully")
                // Handle success (e.g., navigate to the main screen)
            }
        }
    }

    func logIn(email: String, password: String, whenSuccess: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login failed with error: \(error.localizedDescription)")
                // Handle error appropriately (e.g., show an alert)
            } else {
                print("User logged in successfully")
                whenSuccess()
            }
        }
    }

    func signOut(whenSuccess: @escaping () -> ()) {
        do {
            try Auth.auth().signOut()
            print("User signed out successfully")
            whenSuccess()
        } catch let error {
            print("Sign out failed with error: \(error.localizedDescription)")
            // Handle error appropriately (e.g., show an alert)
        }
    }
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
}
