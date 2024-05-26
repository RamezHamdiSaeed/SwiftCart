//
//  SettingViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 26/05/2024.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var moode: UISegmentedControl!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var logout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logout.layer.cornerRadius = 10

    }
    
    @IBAction func navigateToAdresses(_ sender: Any) {
        if let adressesViewController = (storyboard?.instantiateViewController(withIdentifier: "AdressesTableViewController")) as? AdressesTableViewController{
            self.navigationController?.pushViewController(adressesViewController, animated: true)
        }
        
    }
    
    

}
