//
//  AuthViewModelImpl.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 26/05/2024.
//

import Foundation

class AuthViewModelImpl : AuthViewModel{
    
    
    let signUPNavigationHandler : ()->()
    let logInNavigationHandler : ()->()
    let continueAsAGuestHandler : ()->()
    let logInHandler : ()->()
    let signUpHandler : ()->()
    init(signUPNavigationHandler: @escaping () -> Void, logInNavigationHandler: @escaping () -> Void, continueAsAGuestHandler: @escaping () -> Void, logInHandler: @escaping () -> Void, signUpHandler: @escaping () -> Void) {
        self.signUPNavigationHandler = signUPNavigationHandler
        self.logInNavigationHandler = logInNavigationHandler
        self.continueAsAGuestHandler = continueAsAGuestHandler
        self.logInHandler = logInHandler
        self.signUpHandler = signUpHandler
    }
    
    func setSuccessMessage(successMessage: @escaping (() -> ())) {
        FirebaseAuthImpl.user.successMessage(successMessage: successMessage)
        
    }
    
    func signUpNavigation() {
        self.signUPNavigationHandler()
    }
    
    func logInNavigation() {
        self.logInNavigationHandler()
    }
    
    func continueAsAGuest() {
        self.continueAsAGuestHandler()
    }
    
    func logIn() {
        self.logInHandler()
    }
    
    func signUp() {
        self.signUpHandler()
    }
    
    
}
