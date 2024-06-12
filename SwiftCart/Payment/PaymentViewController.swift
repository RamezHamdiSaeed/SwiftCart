//
//  PaymentViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 12/06/2024.
//

import UIKit

class PaymentViewController: UIViewController {
    var selectedAddress : Address?
    var draftOrders : [DraftOrder]?
    var customerId = User.id

    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var cashButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        handleButtonImgs()
        if let address = selectedAddress {
                 print("Selected Address: \(address)")
             }
             print("Draft Orders: \(draftOrders)")
             print("Customer ID: \(customerId)")
         }
        
    


    func handleButtonImgs(){
              cashButton.setImage(UIImage(named: "cashImage"), for: .normal)

              cashButton.imageView?.contentMode = .scaleAspectFit

              cashButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        applePayButton.setImage(UIImage(named: "apple"), for: .normal)

        applePayButton.imageView?.contentMode = .scaleAspectFit

        applePayButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }

}
