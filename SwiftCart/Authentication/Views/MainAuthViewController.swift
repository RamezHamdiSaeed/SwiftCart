//
//  MainAuthViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import UIKit

class MainAuthViewController: UIViewController {
     var authVC : AuthViewModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         authVC = AuthViewModelImpl(signUPNavigationHandler: signUpNavigation, logInNavigationHandler: logInNavigation, continueAsAGuestHandler: continueAsAGuest, logInHandler: {}, signUpHandler: {})
        navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func continuseAsAGuestBtn(_ sender: Any) {
      authVC!.continueAsAGuest()
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
       authVC!.signUpNavigation()
    }
    
    
    @IBAction func logInBtn(_ sender: Any) {
    authVC!.logInNavigation()
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
        
    }
    
}
