//
//  InputValidator.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 25/05/2024.
//

import Foundation
class InputValidator{
    
    static func isValidEmail(email : String) -> Bool{
        let regex =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return regexPredicate.evaluate(with: email)
    }
    static func isValidPassword(password : String) -> Bool{
        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return regexPredicate.evaluate(with: password)
    }
}
