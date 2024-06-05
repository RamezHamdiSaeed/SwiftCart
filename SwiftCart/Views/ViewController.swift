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
        BrandServiceImp.fetchBrands { res in
            switch res {
            case .success(_) : print("success")
            case .failure(_):
                print("error")
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let storyboard1 = UIStoryboard(name: "HomeAndCategories", bundle: nil)
        let home = (storyboard1.instantiateViewController(withIdentifier: "tb") as? UITabBarController)!

        navigationController?.pushViewController(home, animated: true)
    }
   



    @IBAction func navigate(_ sender: Any) {
        let settingStoryboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        if let viewcontroller = settingStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as?
            SettingViewController{
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }

}

