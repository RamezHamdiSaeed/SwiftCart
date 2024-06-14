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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     authVC = AuthViewModelImpl(signUPNavigationHandler: signUpNavigation, logInNavigationHandler: {}, continueAsAGuestHandler: {}, logInHandler: userLogIn, signUpHandler: {})
        authVC?.setSuccessMessage(successMessage: {
            FeedbackManager.successSwiftMessage(title: "Prompt", body: "Logged In Successfully")
        })
        authVC?.setFailMessage(failMessage: {
            FeedbackManager.errorSwiftMessage(title: "Error", body: "Not Signed Up Yet")
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        password.isSecureTextEntry = true

    }

    @IBAction func userLogInBtn(_ sender: Any) {
          authVC!.logIn()

    }
    
    @IBAction func signUpBtn(_ sender: Any) {
          authVC!.signUpNavigation()

    }
   
    
    func userLogIn(){
        let isValidEmail = InputValidator.isValidEmail(email: email.text ?? "")
        let isValidPassword = InputValidator.isValidPassword(password: password.text ?? "")
        
        if(isValidEmail && isValidPassword){
            
            FirebaseAuthImpl.user.logIn(email: email.text!, password: password.text!){
                DispatchQueue.main.async{
                    let storyboard1 = UIStoryboard(name: "HomeAndCategories", bundle: nil)
                           let home = (storyboard1.instantiateViewController(withIdentifier: "tb") as? UITabBarController)!
                    
                    self.navigationController?.pushViewController(home, animated: true)
                }

            }
            
            
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
