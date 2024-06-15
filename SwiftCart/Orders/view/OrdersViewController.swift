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
    var rate : Double!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()

    
    @IBOutlet weak var ordersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(view: self.view)
        styleTableView(tableView: ordersTableView)
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.reloadData()
        setHeader(view: self, title: "Orders")

        
        ordersViewModel = OrdersViewModel()
        ordersViewModel.ordersClosure = {
         [weak self]   res in
            DispatchQueue.main.async {
                
                self?.orders = res
                self?.ordersTableView.reloadData()

            }        }
        ordersViewModel.getOrders()
        ordersViewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        ordersViewModel.getRate()


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
       
        cell.orderNumberLabel.text = "\(indexPath.item)"
        var convertedPrice = convertPrice(price: String(order.totalPrice ?? "0.0" ), rate: self.rate)
        cell.orderPriceLabel.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"

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


