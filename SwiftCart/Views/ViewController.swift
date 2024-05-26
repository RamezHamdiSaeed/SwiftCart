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


    @IBAction func navigate(_ sender: Any) {
        let settingStoryboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        if let viewcontroller = settingStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as?
            SettingViewController{
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}

