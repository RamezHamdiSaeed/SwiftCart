//
//  FirebaseAuth.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import Foundation

protocol FirebaseAuth{
    func signUp(email : String, password : String)
    func logIn(email : String, password : String)
    func signOut()
}
