//
//  AuthViewModelImpl.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 26/05/2024.
//

import Foundation

class AuthViewModelImpl : AuthViewModel{
    
    func setSuccessMessage(successMessage: @escaping (() -> ())) {
        FirebaseAuthImpl.user.successMessage(successMessage: successMessage)
    }
        func setFailMessage(failMessage: @escaping (() -> ())){
        FirebaseAuthImpl.user.failMessage(failMessage: failMessage)
    }
    
    func signUp(email:String,password:String,whenSuccess:(()->())?) {
        
        FirebaseAuthImpl.user.signUp(email: email, password: password){
            whenSuccess?()
        }

        
    }
    
    func logIn(email:String,password:String,whenSuccess:(()->())?) {
        
        FirebaseAuthImpl.user.logIn(email: email, password: password){
            
            FavoriteSync.fetchProducts(for: User.email!, completion: {
                products in
                products.forEach{
                    currentProduct in
                  LocalDataSourceImpl.shared.insertProductToFav(product: currentProduct)
                }
            })
            
            AppCommon.userSessionManager.setIsNotSignedOutUser()
            whenSuccess?()
        }
    }
    
    func logOut(whenSuccess:(()->())?) {
        FirebaseAuthImpl.user.signOut(whenSuccess:{
            guard let favoriteProducts = LocalDataSourceImpl.shared.getProductsFromFav() else {return}
            FavoriteSync.uploadProducts(for: User.email!, products: favoriteProducts)
            favoriteProducts.forEach{
                currentProduct in
                LocalDataSourceImpl.shared.deleteProductFromFav(product: currentProduct)
                whenSuccess?()
            }
            AppCommon.userSessionManager.setIsSignedOutUser()

                
        })
       
    }
    

    
    
}
