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
    

   private func setHeader(){
        let titleLabel = UILabel()
               titleLabel.text = "About Us"
               titleLabel.textColor = .systemPink
               titleLabel.font = .boldSystemFont(ofSize: 25)
               titleLabel.sizeToFit()

               let titleItem = UIBarButtonItem(customView: titleLabel)
               navigationItem.titleView = titleLabel
           
        
    }
}
