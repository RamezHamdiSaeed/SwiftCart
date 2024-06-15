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
        
        ordersViewModel = OrdersViewModel()
        ordersViewModel.ordersClosure = {
         [weak self]   res in
            DispatchQueue.main.async {
                
                self?.orders = res
                self?.ordersTableView.reloadData()
                self?.updateEmptyImageView()

            }        }
        ordersViewModel.getOrders()
        ordersViewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        ordersViewModel.getRate()
        setHeader(view: self, title: "Orders")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ordersViewModel.getOrders()
    }
    @IBOutlet weak var emptyImageView: UIImageView!
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
        //cell.orderPriceLabel.text = order.totalPrice
        cell.orderSippedLabel.text = order.shippingAddress?.address1
        
        var convertedPrice = convertPrice(price: String(order.totalPrice ?? "0.0" ), rate: self.rate)
        cell.orderPriceLabel.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"


        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderDetails = storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController
        orderDetails?.order = orders[indexPath.item]
        navigationController?.pushViewController(orderDetails!, animated: true)
    }
    
    func updateEmptyImageView() {
        if orders.isEmpty {
            emptyImageView.isHidden = false
            ordersTableView.isHidden = true
        } else {
            emptyImageView.isHidden = true
            ordersTableView.isHidden = false
            ordersTableView.reloadData()
        }
     }
}


