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
        setBackground(view: self.view)
        userNameLabel.text = extractName(from: User.email ?? "Guest@gmail.com")
        if User.phone != nil {
            phoneNumber.text = User.phone
        }else{
            phoneNumber.text = "Phone Number"
        }
    }
    @IBOutlet weak var phoneNumber: UILabel!
    

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func settingBtn(_ sender: Any) {
        let settingStoryboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        if let viewcontroller = settingStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as?
            SettingViewController{
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }

    
    @IBAction func wishListBtn(_ sender: Any) {
        if User.id == nil {
            AppCommon.feedbackManager.showAlert(alertTitle: "", alertMessage: "You need to Log In", alertStyle: .alert, view: self)
        }else{
            let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
            let SearchViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "FavoriteViewController"))
            self.navigationController?.pushViewController(SearchViewController, animated: true)
        }
        
    }
    @IBAction func ordersBtn(_ sender: Any) {
        if User.id == nil {
       
            AppCommon.feedbackManager.showAlert(alertTitle: "", alertMessage: "You are not logged in", alertStyle: .alert, view: self)
        }else{
            let ordersViewController = storyboard?.instantiateViewController(withIdentifier: "OrdersViewController") as? OrdersViewController
            navigationController?.pushViewController(ordersViewController!, animated: true)
        }
        
    }
}
