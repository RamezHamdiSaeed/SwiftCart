//
//  SignUpViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 25/05/2024.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    var authVC : AuthViewModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        authVC = AuthViewModelImpl(signUPNavigationHandler: {}, logInNavigationHandler: logInNavigation, continueAsAGuestHandler: {}, logInHandler: {}, signUpHandler: userSignUp)
        authVC?.setSuccessMessage(successMessage: {
            FeedbackManager.successSwiftMessage(title: "Prompt", body: "Signed Up Successfully")
        })
        authVC?.setFailMessage(failMessage: {
            FeedbackManager.errorSwiftMessage(title: "Error", body: "The Account Already Exists")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
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
            
            FirebaseAuthImpl.user.signUp(email: email.text!, password: password.text!)

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
    func setHeader() {
        let settingsLabel = UILabel()
        settingsLabel.text = "Sign Up"
        settingsLabel.textColor = .systemPink
        settingsLabel.font = .boldSystemFont(ofSize: 25)
        settingsLabel.sizeToFit()
        self.navigationItem.titleView = settingsLabel
    }
}
