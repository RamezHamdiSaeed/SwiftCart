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
    func setFailMessage(failMessage: @escaping (() -> ())){
        FirebaseAuthImpl.user.failMessage(failMessage: failMessage)
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
    
    static func logOut() {
        FirebaseAuthImpl.user.signOut(whenSuccess:{
            guard let favoriteProducts = LocalDataSourceImpl.shared.getProductsFromFav() else {return}
            FavoriteSync.uploadProducts(for: User.email!, products: favoriteProducts)
            favoriteProducts.forEach{
                currentProduct in
                LocalDataSourceImpl.shared.deleteProductFromFav(product: currentProduct)
            }
        })
       
    }
    
    func signUp() {
        self.signUpHandler()
    }
    
    
}
