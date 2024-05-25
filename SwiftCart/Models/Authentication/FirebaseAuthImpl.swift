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
    
    private init(){
        FirebaseApp.configure()
    }
    
    func signUp(email: String, password: String,firstName: String, lastName : String) {
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in
            guard let error else {
                AppCommon.user.firstName = firstName
                AppCommon.user.lastName = lastName
                return
                
            }
            print(error.localizedDescription)
        }
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
            guard let error else {
                AppCommon.user.email = email
                return}
            print(error.localizedDescription)
        }
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut()
        }
        catch{
            
        }
    }
    
    
    
}
