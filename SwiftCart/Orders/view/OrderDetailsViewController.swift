//
//  OrderDetailsViewController.swift
//  SwiftCart
//
//  Created by marwa on 08/06/2024.
//

import UIKit
import SDWebImage

class OrderDetailsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    
    var order : Order!
    var orderItems : [LineItem] = []
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var shippingAddressLabel: UILabel!
    @IBOutlet weak var orderdateLabel: UILabel!
    
    @IBOutlet weak var orderPhoneLabel: UILabel!
    @IBOutlet weak var orderItemsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderItemsTableView.delegate = self
        orderItemsTableView.dataSource = self
        orderItemsTableView.reloadData()
        orderItems = order.lineItems!
        orderdateLabel.text = order.createdAt
        orderPhoneLabel.text = order.phone
        totalPriceLabel.text = order.totalPrice
        shippingAddressLabel.text = order.shippingAddress?.address1

       
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = orderItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OrderDetailTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure Cell
        let product = orderItems[indexPath.item]
        
        cell.orderProductsName.text = product.title
        cell.orderProductsPrice.text = "Price : \(product.price!)"
        cell.orderProductsQuantity.text = "Qouantity : \(product.quantity!)"
//        if let imageUrl = URL(string: product.sku!) {
//            cell.orderProductsImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "catimg"))
//        } else {
//            cell.orderProductsImage.image = UIImage(named: "catimg")
//        }

         
            print("",product.sku!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 }
}
