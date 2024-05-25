//
//  LogInViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 25/05/2024.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func userLogInBtn(_ sender: Any) {
        let isValidEmail = InputValidator.isValidEmail(email: email.text ?? "")
        let isValidPassword = InputValidator.isValidPassword(password: password.text ?? "")
        
        if(isValidEmail && isValidPassword){
            
            FirebaseAuthImpl.user.logIn(email: email.text!, password: password.text!)
            
            FeedbackManager.rigularSwiftMessage(title: "Prompt", body: "Logged In Successfully")
            
        }
        else if (!isValidEmail){
            email.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.rigularSwiftMessage(title: "InValidInput", body: "Wrong Email Or Password")

        }
        else{
            
            password.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.rigularSwiftMessage(title: "InValidInput", body: "Wrong Email Or Password")

        }
    }
    
    @IBAction func userLogInBtnWithApple(_ sender: Any) {
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let signUpVC:SignUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}
