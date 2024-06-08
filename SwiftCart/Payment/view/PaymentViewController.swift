//
//  PaymentViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 08/06/2024.
//

import UIKit
import PayPalCheckout

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = CheckoutConfig(
            clientID: "AVrBvbRT6qXlhAbOqi52-ALjI5IyVYexDxemwlKgODzZiwG53tUPMdjh_RRui6SqrX3pdIjf9pmxCImq", // Replace with your sandbox client ID
                  environment: .sandbox // Use .live for production
              )
              Checkout.set(config: config)
    }

    @IBAction func payWithPayPal(_ sender: Any) {
        Checkout.start()
        let amount = PurchaseUnit.Amount(currencyCode: .usd, value: "10.00")
        let purchaseUnit = PurchaseUnit(amount: amount)
        let order = OrderRequest(intent: .capture, purchaseUnits: [purchaseUnit])

        Checkout.setCreateOrderCallback { createOrderAction in
            createOrderAction.create(order: order)
        }

        Checkout.setOnApproveCallback { approval in
            approval.actions.capture { (response, error) in
                if let response = response {
                    print("Order successfully captured: \(response)")
                } else if let error = error {
                    print("Error capturing order: \(error)")
                }
            }
        }

        Checkout.setOnCancelCallback {
            print("Order was canceled")
        }

        Checkout.setOnErrorCallback { errorInfo in
            print("Error occurred: \(errorInfo)")
        }

        Checkout.start()
    }
}
