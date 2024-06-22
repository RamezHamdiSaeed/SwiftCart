//
//  AuthViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 26/05/2024.
//

import Foundation
import UIKit
protocol AuthViewModel{
    func setSuccessMessage(successMessage:@escaping(()->()))
    func setFailMessage(failMessage: @escaping (() -> ()))
    func logIn(email:String,password:String,whenSuccess:(()->())?)
    func logInWithGoogle(view : UIViewController,whenSuccess:@escaping()->())
    func signUp(email:String,password:String,whenSuccess:(()->())?)
     func logOut(whenSuccess:(()->())?)
}
