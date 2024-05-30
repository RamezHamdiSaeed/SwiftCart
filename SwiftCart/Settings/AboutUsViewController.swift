//
//  AboutUsViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 31/05/2024.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setHeader()
        
    }
    

    func setHeader(){
        let settingsLabel = UILabel()
        settingsLabel.text = "About Us"
        settingsLabel.textColor = .systemPink
        settingsLabel.font = .boldSystemFont(ofSize: 25)
        settingsLabel.sizeToFit()
        let setting  = UIBarButtonItem (customView: settingsLabel)
        self.navigationItem.titleView = settingsLabel
        
    }
}
