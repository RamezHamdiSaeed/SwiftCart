//
//  AboutUsViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 31/05/2024.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var frameOne: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyleToFrame(to: frameOne)
        applyStyleToFrame(to: frameTwo)
        applyStyleToFrame(to: frameThree)

        setHeader(view: self , title: "About Us")
        
    }
    
    @IBOutlet weak var frameThree: UIView!
    
    
    @IBOutlet weak var frameTwo: UIView!
    @IBAction func thirdMember(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/in/ramez-hamdi") {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }

    }
    @IBAction func secMember(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/in/rwan-el-mtary") {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }

    }
    @IBAction func firstMember(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/in/marwa-mohamed-abdelghany") {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }
    }
    
   
  
}

func applyStyleToFrame(to view: UIView) {
    var color : UIColor = .systemOrange
    view.layer.borderWidth = 2.0
    view.layer.borderColor = color.cgColor
    view.layer.cornerRadius = 10.0
    view.layer.masksToBounds = true
}
