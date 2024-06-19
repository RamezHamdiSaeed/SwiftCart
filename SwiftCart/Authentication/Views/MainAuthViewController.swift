//
//  MainAuthViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import UIKit

class MainAuthViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startMonitoringConnection()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopMonitoringConnection()
    }

    @IBAction func continuseAsAGuestBtn(_ sender: Any) {
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
    
}
