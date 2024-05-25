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
    }

    @IBAction func continuseAsAGuestBtn(_ sender: Any) {
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let signUpVC:SignUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    @IBAction func logInBtn(_ sender: Any) {
        let logInVC:LogInViewController = LogInViewController()
        self.navigationController?.pushViewController(logInVC, animated: true)
    }
    
}
