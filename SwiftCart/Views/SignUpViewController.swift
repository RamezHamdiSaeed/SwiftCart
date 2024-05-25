//
//  SignUpViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 25/05/2024.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    
    
    @IBOutlet weak var lastName: UITextField!
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func userSignUpBtn(_ sender: Any) {
        
        let isValidEmail = InputValidator.isValidEmail(email: email.text ?? "")
        let isValidPassword = InputValidator.isValidPassword(password: password.text ?? "")
        
        if(isValidEmail && isValidPassword){
            
            FirebaseAuthImpl.user.signUp(email: email.text!, password: password.text!,firstName: firstName.text ?? "", lastName: lastName.text ?? "")
            FeedbackManager.rigularSwiftMessage(title: "Prompt", body: "Signed Up Successfully")

            
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
    
    @IBAction func logInBtn(_ sender: Any) {
        
        let logInVC:LogInViewController = LogInViewController()
        self.navigationController?.pushViewController(logInVC, animated: true)
    }
}
