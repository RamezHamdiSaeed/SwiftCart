//
//  SignUpViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 25/05/2024.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    var authVC : AuthViewModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.keyboardType = .numberPad

        authVC = AuthViewModelImpl()
        authVC?.setSuccessMessage(successMessage: {
            self.showSnackbar(message: "Signed Up Successfully")

        })
        authVC?.setFailMessage(failMessage: {
            FeedbackManager.errorSwiftMessage(title: "", body: "The Account Already Exists")
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
        let isValidPhone = self.phone.text?.count == 11


         if (!isValidEmail){
            email.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.errorSwiftMessage(title: "", body: "Wrong Email")
            self.email.text = ""
             self.phone.text = ""
            self.password.text = ""
             self.confirmPassword.text = ""

        }
        else if (!isValidPhone){
            phone.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.errorSwiftMessage(title: "", body: "Wrong phone number")
            self.phone.text = ""
            self.password.text = ""
             self.confirmPassword.text = ""
            
        }
        else if (!isValidPassword){
            
            password.layer.borderColor = UIColor.red.cgColor
            FeedbackManager.errorSwiftMessage(title: "", body: "WrongPassword")
            self.password.text = ""
            self.confirmPassword.text = ""

        }
        else if self.confirmPassword.text != self.password.text{
            FeedbackManager.errorSwiftMessage(title: "", body: "Don't Match")
            self.password.text = ""
            self.confirmPassword.text = ""
        }
        else {
            
            authVC?.signUp(email: email.text!, password: password.text!, phone: phone.text!, whenSuccess: {
                
                DispatchQueue.main.async{
                    self.logInNavigation()
                }
            })
            
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
