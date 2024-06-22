//
//  AuthViewModelImpl.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 26/05/2024.
//

import Foundation
import UIKit
class AuthViewModelImpl : AuthViewModel{

    
    
    func setSuccessMessage(successMessage: @escaping (() -> ())) {
        GoogleAuthImpl.user.successMessage(successMessage: successMessage)
    }
        func setFailMessage(failMessage: @escaping (() -> ())){
        GoogleAuthImpl.user.failMessage(failMessage: failMessage)
    }
    
    func signUp(email:String,password:String,whenSuccess:(()->())?) {
        
        GoogleAuthImpl.user.signUp(email: email, password: password){
            whenSuccess?()
        }

        
    }
    
    func logIn(email:String,password:String,whenSuccess:(()->())?) {
        
        GoogleAuthImpl.user.logIn(email: email, password: password){
            
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
    
    func logInWithGoogle(view : UIViewController,whenSuccess: @escaping () -> ()) {
    
        GoogleAuthImpl.user.logInWithGoogle(view: view, whenSuccess: {
            FavoriteSync.fetchProducts(for: User.email!, completion: {
                products in
                products.forEach{
                    currentProduct in
                  LocalDataSourceImpl.shared.insertProductToFav(product: currentProduct)
                }
            })
            
            AppCommon.userSessionManager.setIsNotSignedOutUser()
            whenSuccess()
        })
    }
    
    func logOut(whenSuccess:(()->())?) {
        GoogleAuthImpl.user.signOut(whenSuccess:{
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
