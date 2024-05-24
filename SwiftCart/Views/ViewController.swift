//
//  ViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 23/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let storyboard1 = UIStoryboard(name: "HomeAndCategories", bundle: nil)
        let home = (storyboard1.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
        navigationController?.pushViewController(home, animated: true)
    }
   
}

