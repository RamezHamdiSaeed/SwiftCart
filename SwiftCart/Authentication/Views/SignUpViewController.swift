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
    
    var authVC : AuthViewModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        authVC = AuthViewModelImpl(signUPNavigationHandler: {}, logInNavigationHandler: logInNavigation, continueAsAGuestHandler: {}, logInHandler: {}, signUpHandler: userSignUp)
        authVC?.setSuccessMessage(successMessage: {
            FeedbackManager.successSwiftMessage(title: "Prompt", body: "Signed Up In Successfully")
        })
        authVC?.setFailMessage(failMessage: {
            FeedbackManager.errorSwiftMessage(title: "Error", body: "The Account Already Exists")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
    }
    

    @IBAction func userSignUpBtn(_ sender: Any) {
        authVC!.signUp()

       
        
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        authVC!.logInNavigation()

    }
    
    
    func userSignUp(){
        let isValidEmail = InputValidator.isValidEmail(email: email.text ?? "")
        let isValidPassword = InputValidator.isValidPassword(password: password.text ?? "")
        
        if(isValidEmail && isValidPassword){
            
            FirebaseAuthImpl.user.signUp(email: email.text!, password: password.text!,firstName: firstName.text ?? "", lastName: lastName.text ?? "")

        }
        else if (!isValidEmail){
            email.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.errorSwiftMessage(title: "InValidInput", body: "Wrong Email Or Password")
        }
        else{
            
            password.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.errorSwiftMessage(title: "InValidInput", body: "Wrong Email Or Password")

        }
        
    }
    
    func logInNavigation(){
        let logInVC:LogInViewController = (self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController")) as! LogInViewController
        self.navigationController?.pushViewController(logInVC, animated: true)
    }
}
