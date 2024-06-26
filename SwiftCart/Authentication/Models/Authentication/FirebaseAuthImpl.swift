//
//  FirebaseAuth.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import Foundation
import Firebase
class FirebaseAuthImpl : FirebaseAuth{
    
    static let user = FirebaseAuthImpl()
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
