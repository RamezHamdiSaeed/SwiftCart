//
//  PaymentViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 12/06/2024.
//

import UIKit

class PaymentViewController: UIViewController {
    var selectedAddress: Address?
    var draftOrders: [DraftOrder]?
    var customerId = User.id
    var viewModel = CartViewModel()
    weak var delegate: PaymentDelegate?


    @IBOutlet weak var totalLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        if let address = selectedAddress {
            print("Selected Address: \(address)")
        }
        print("Draft Orders: \(draftOrders)")
        print("Customer ID: \(customerId)")

        calculateAndDisplayTotalPrice()
    }

    func calculateAndDisplayTotalPrice() {
        let totalPrice = draftOrders?.reduce(0.0) { total, draftOrder in
            let orderTotal = Double(draftOrder.totalPrice ?? "") ?? 0.0
            return total + orderTotal
        }
        totalLabel.text = String(format: "$%.2f", totalPrice ?? 0.0)
    }

    @IBAction func buyWithCash(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm Purchase", message: "Are you sure you want to complete this purchase with Cash on Delivery?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.completePurchase()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    func completePurchase() {
           guard let draftOrders = draftOrders else { return }
           viewModel.completeDraftOrders(draftOrderIDs: draftOrders.map { $0.id ?? 0 }) { [weak self] success in
               DispatchQueue.main.async {
                   if success {
                       self?.viewModel.deleteDraftOrders(draftOrderIDs: draftOrders.map { $0.id ?? 0 }) { deleteSuccess in
                           DispatchQueue.main.async {
                               if deleteSuccess {
                                   let successAlert = UIAlertController(title: "Success", message: "Your order has been completed and draft orders have been deleted.", preferredStyle: .alert)
                                   successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                   self?.present(successAlert, animated: true, completion: nil)
                               } else {
                                   let failureAlert = UIAlertController(title: "Warning", message: "Your order has been completed but failed to delete draft orders.", preferredStyle: .alert)
                                   failureAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                   self?.present(failureAlert, animated: true, completion: nil)
                               }
                           }
                       }
                   } else {
                       let failureAlert = UIAlertController(title: "Error", message: "Failed to complete your order. Please try again.", preferredStyle: .alert)
                       failureAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self?.present(failureAlert, animated: true, completion: nil)
                   }
               }
           }
       }
   }
