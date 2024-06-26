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
    
     var authVC : AuthViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        authVC = AuthViewModelImpl()
           authVC?.setSuccessMessage(successMessage: {
               self.showSnackbar(message: "Logged In Successfully")
           })
           authVC?.setFailMessage(failMessage: {
               FeedbackManager.errorSwiftMessage(title: "Error", body: "Not Signed Up Yet")
           })
        
        SwiftCart.setHeader(view: self, title: "Login")

        password.isSecureTextEntry = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true

    }
    @IBAction func userLogInBtn(_ sender: Any) {
        self.userLogIn()

    }
    
    @IBAction func signUpBtn(_ sender: Any) {
          self.signUpNavigation()

    }
   
    
    func userLogIn(){
        let isValidEmail = InputValidator.isValidEmail(email: email.text ?? "")
        let isValidPassword = InputValidator.isValidPassword(password: password.text ?? "")
        
        if(isValidEmail && isValidPassword){
            
            authVC?.logIn(email: email.text!, password: password.text!, whenSuccess: {
                DispatchQueue.main.async{
                    let storyboard1 = UIStoryboard(name: "HomeAndCategories", bundle: nil)
                           let home = (storyboard1.instantiateViewController(withIdentifier: "tb") as? UITabBarController)!
                    
                    self.navigationController?.pushViewController(home, animated: true)
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
    
    
    func signUpNavigation(){
        let signUpVC = (self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController"))!
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    func setHeader() {
        let settingsLabel = UILabel()
        settingsLabel.text = "Log In"
        settingsLabel.textColor = .systemPink
        settingsLabel.font = .boldSystemFont(ofSize: 25)
        settingsLabel.sizeToFit()
        self.navigationItem.titleView = settingsLabel
        
        
    }
}
