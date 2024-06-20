//
//  FirebaseAuth.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import Foundation

protocol FirebaseAuth{
    func signUp(email : String, password : String,whenSuccess:@escaping()->())
    func logIn(email : String, password : String,whenSuccess:@escaping()->())
    func signOut(whenSuccess:@escaping()->())
}
