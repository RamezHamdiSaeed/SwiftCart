//
//  FirebaseAuth.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import Foundation
import Firebase
import GoogleSignIn

class GoogleAuthImpl : GoogleAuth{
    
    static let user = GoogleAuthImpl()
    let shopifyAuthNetworkServiceImpl:ShopifyAuthNetworkServiceImpl = ShopifyAuthNetworkServiceImpl(networkingManager: NetworkingManagerImpl())
     var successMessage : (()->())?
    var failMessage : (()->())?
    
    private init(){
        FirebaseApp.configure()
    }
    
    func successMessage(successMessage : @escaping ()->()){
        self.successMessage = successMessage
    }
    
    func failMessage(failMessage : @escaping ()->()){
        self.failMessage = failMessage
    }
    
    func signUp(email: String, password: String,whenSuccess:@escaping()->()) {
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in
            guard let error else {
                self.successMessage!()
                self.shopifyAuthNetworkServiceImpl.createCustomer(customer: SignedUpCustomer(customer: SignedUpCustomerInfo(email: email,verifiedEmail: true,state: "enabled")))
                whenSuccess()
                return
                
            }
            self.failMessage!()
            print(error.localizedDescription)
        }
    }
    
    func logIn(email: String, password: String,whenSuccess:@escaping()->()) {
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
            guard let error else {
                self.successMessage!()
                self.shopifyAuthNetworkServiceImpl.getLoggedInCustomerByEmail(email: email){
                whenSuccess()
                }
                return}
            self.failMessage!()
            print(error.localizedDescription)
        }
    }
    func logInWithGoogle(view:UIViewController,whenSuccess: @escaping () -> ()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
               let config = GIDConfiguration(clientID: clientID)
               
               GIDSignIn.sharedInstance.configuration = config
               GIDSignIn.sharedInstance.signIn(withPresenting: view) { signInResult, error in
                   guard error == nil else {
                       print("Error while logging in: \(error?.localizedDescription ?? "Unknown error")")
                       return
                   }
                   guard let signInResult = signInResult else { return }

                   let user = signInResult.user
                   let userEmail = user.profile?.email

                   user.refreshTokensIfNeeded { auth, error in
                       if let error = error {
                           print("Error during token refresh: \(error.localizedDescription)")
                           return
                       }

                       guard let auth = auth else {
                           print("No authentication object found")
                           return
                       }

                       let idToken = auth.idToken
                       let accessToken = auth.accessToken

                       let credential = GoogleAuthProvider.credential(withIDToken: idToken!.tokenString, accessToken: accessToken.tokenString)

                       Auth.auth().signIn(with: credential) { authResult, error in
                           if let error = error {
                               print("Firebase sign-in error: \(error.localizedDescription)")
                               return
                           }

                           guard let authResult = authResult else { return }

                           if let email = userEmail {
                               print("Logged in user email: \(email)")
                               self.shopifyAuthNetworkServiceImpl.getLoggedInCustomerByEmail(email: email) {
                                   whenSuccess()
                               }
                           } else {
                               print("Email is not available")
                               self.failMessage?()
                           }
                       }
                   }
               }
                
                    
        }
    
    
    func signOut(whenSuccess:@escaping()->()) {
        do{
            try Auth.auth().signOut()
            whenSuccess()
        }
        catch{
            
            print("signOutError")
        }
    }
    
    
    
}
