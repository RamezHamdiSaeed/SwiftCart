//
//  MeViewController.swift
//  SwiftCart
//
//  Created by marwa on 07/06/2024.
//

import UIKit

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func settingBtn(_ sender: Any) {
    }
    @IBAction func wishlistBtn(_ sender: Any) {
    }
    
    @IBAction func ordersBtn(_ sender: Any) {
        let ordersViewController = storyboard?.instantiateViewController(withIdentifier: "OrdersViewController") as? OrdersViewController
        navigationController?.pushViewController(ordersViewController!, animated: true)
    }
    
}
