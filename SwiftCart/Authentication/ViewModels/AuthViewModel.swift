//
//  AuthViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 26/05/2024.
//

import Foundation

protocol AuthViewModel{
    func  signUpNavigation()
    func  logInNavigation()
    func continueAsAGuest()
    func logIn()
    func signUp()
    func setSuccessMessage(successMessage:@escaping(()->()))
    func setFailMessage(failMessage: @escaping (() -> ()))
}
