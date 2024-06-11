//
//  OrdersViewController.swift
//  SwiftCart
//
//  Created by marwa on 07/06/2024.
//

import UIKit

class OrdersViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    var orders : [Order] = []
    var ordersViewModel : OrdersViewModel!
    
    @IBOutlet weak var ordersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.reloadData()
        
        ordersViewModel = OrdersViewModel()
        ordersViewModel.ordersClosure = {
         [weak self]   res in
            DispatchQueue.main.async {
                
                self?.orders = res
                self?.ordersTableView.reloadData()

            }        }
        ordersViewModel.getOrders()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ordersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OrdersTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure Cell
        let order = orders[indexPath.item]
        
        cell.orderDateLabel.text = order.createdAt
        cell.orderPhoneLabel.text = order.phone
        cell.orderNumberLabel.text = "\(indexPath.item)"
        cell.orderPriceLabel.text = order.totalPrice
        cell.orderSippedLabel.text = order.shippingAddress?.address1
         


        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderDetails = storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController
        orderDetails?.order = orders[indexPath.item]
        navigationController?.pushViewController(orderDetails!, animated: true)
    }
}


