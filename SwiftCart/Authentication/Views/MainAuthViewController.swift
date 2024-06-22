//
//  MainAuthViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import UIKit
import GoogleSignIn

class MainAuthViewController: UIViewController {

    @IBOutlet weak var googleLoginBtn: GIDSignInButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader(view: self, title: "Trendy")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.googleLoginBtn.addGestureRecognizer(tapGestureRecognizer)
        

    }

    @IBAction func continuseAsAGuestBtn(_ sender: Any) {
        AppCommon.userSessionManager.setIsSignedOutUser()
      self.continueAsAGuest()
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
       self.signUpNavigation()
    }
    
    
    @IBAction func logInBtn(_ sender: Any) {
    self.logInNavigation()
    }
    
    func signUpNavigation(){
        let signUpVC = (self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController"))!
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func logInNavigation(){
        let logInVC:LogInViewController = (self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController")) as! LogInViewController
        self.navigationController?.pushViewController(logInVC, animated: true)
    }
    
    func continueAsAGuest(){
        let storyboard1 = UIStoryboard(name: "HomeAndCategories", bundle: nil)
               let home = (storyboard1.instantiateViewController(withIdentifier: "tb") as? UITabBarController)!
        
               navigationController?.pushViewController(home, animated: true)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {

        print("google Log In tapped")
        let authVC : AuthViewModel = AuthViewModelImpl()
        authVC.logInWithGoogle(view: self, whenSuccess: {
            self.showSnackbar(message: "Logged In Successfully")
            DispatchQueue.main.async{
                let storyboard1 = UIStoryboard(name: "HomeAndCategories", bundle: nil)
                       let home = (storyboard1.instantiateViewController(withIdentifier: "tb") as? UITabBarController)!
                
                self.navigationController?.pushViewController(home, animated: true)
            }
        })
        
    }
}
