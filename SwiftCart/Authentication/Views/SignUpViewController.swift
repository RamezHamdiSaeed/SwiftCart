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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        authVC = AuthViewModelImpl()
        authVC?.setSuccessMessage(successMessage: {
            FeedbackManager.successSwiftMessage(title: "", body: "Signed Up Successfully")
        })
        authVC?.setFailMessage(failMessage: {
            FeedbackManager.errorSwiftMessage(title: "Error", body: "The Account Already Exists")
        })
        SwiftCart.setHeader(view: self, title: "Sign Up")

        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true

    }
    

    @IBAction func userSignUpBtn(_ sender: Any) {
        self.userSignUp()

       
        
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        self.logInNavigation()

    }

    
    func userSignUp(){
        let isValidEmail = InputValidator.isValidEmail(email: email.text ?? "")
        let isValidPassword = InputValidator.isValidPassword(password: password.text ?? "")
        
        if(isValidEmail && isValidPassword){
            
            authVC?.signUp(email: email.text!, password: password.text!, whenSuccess: {
                DispatchQueue.main.async{
                    self.logInNavigation()
                }
            })
            
        }
        else if (!isValidEmail){
            email.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.errorSwiftMessage(title: "InValidInput", body: "Wrong Email Or Password")
            self.email.text = ""
            self.password.text = ""

        }
        else{
            
            password.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.errorSwiftMessage(title: "InValidInput", body: "Wrong Email Or Password")
            self.email.text = ""
            self.password.text = ""

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
