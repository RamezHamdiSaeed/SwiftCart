//
//  UserSessionManager.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation

class UserSessionManager{
    static let shared = UserSessionManager()
    
    func isLoggedInuser()->Bool{
        
        var isUserLoggedIn = UserDefaults.standard.string(forKey: "userID") != nil
        if isUserLoggedIn{
            User.id = UserDefaults.standard.integer(forKey: "userID")
            User.email = UserDefaults.standard.string(forKey: "userEmail")
            User.Address = UserDefaults.standard.string(forKey: "userAddress")
            User.phone = UserDefaults.standard.string(forKey: "userPhone")
            print(User.phone)

        }
        return isUserLoggedIn
    }
    
    func setIsNotSignedOutUser(){
        UserDefaults.standard.set(User.id, forKey: "userID")
        UserDefaults.standard.set(User.email, forKey: "userEmail")
        UserDefaults.standard.set(User.Address, forKey: "userAddress")
        UserDefaults.standard.set(User.phone, forKey: "userPhone")

    }
    
    func setIsSignedOutUser(){
        UserDefaults.standard.set(nil, forKey: "userID")
        UserDefaults.standard.set(nil, forKey: "userEmail")
        UserDefaults.standard.set(nil, forKey: "userAddress")
        UserDefaults.standard.set(nil, forKey: "userPhone")

    }
}
