//
//  FirebaseAuth.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import Foundation
import UIKit

protocol GoogleAuth{
    func signUp(email : String, password : String,whenSuccess:@escaping()->())
    func logIn(email : String, password : String,whenSuccess:@escaping()->())
    func logInWithGoogle(view : UIViewController,whenSuccess:@escaping()->())
    func signOut(whenSuccess:@escaping()->())
}
