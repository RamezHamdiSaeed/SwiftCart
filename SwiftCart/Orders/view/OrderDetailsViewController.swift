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
    var ordersViewModel : OrdersViewModel!

    @IBOutlet weak var totalPriceLabel: UILabel!

    @IBOutlet weak var shippingAddressLabel: UILabel!
    @IBOutlet weak var orderdateLabel: UILabel!
    var rate : Double = 0.0
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()


    @IBOutlet weak var orderItemsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersViewModel = OrdersViewModel(networkService: NetworkServicesImpl())

        setBackground(view: self.view)
        styleTableView(tableView: orderItemsTableView)
        orderItemsTableView.delegate = self
        orderItemsTableView.dataSource = self
        orderItemsTableView.reloadData()
        orderItems = order.lineItems!
        //orderdateLabel.text = order.createdAt
        var dateStr = extractDate(from: order.createdAt!)
        orderdateLabel.text = dateStr
        print("orderdateLabel",order.createdAt)

        totalPriceLabel.text = String(order.id!)
        shippingAddressLabel.text = order.shippingAddress?.address1
        setHeader(view: self, title: "Order Details")
      
  
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
        //cell.orderProductsPrice.text = "Price : \(product.price!)"

        ordersViewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                    var convertedPrice = convertPrice(price: String(product.price ?? "0.0" ), rate: self!.rate)
                    cell.orderProductsPrice.text = "\(String(format: "%.2f", convertedPrice)) \(self!.userCurrency)"

                }
        }
        ordersViewModel.getRate()
        cell.orderProductsQuantity.text = "Quantity : \(product.quantity!)"

       let placeholderImage = UIImage(named: "fixed")

        ordersViewModel.getProductDetails(productID: String(product.productId!)){
            res in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if let imageUrlString = res, let imageUrl = URL(string: imageUrlString) {
                    cell.orderProductsImage.sd_setImage(with: imageUrl, placeholderImage: placeholderImage)
                } else {
                    cell.orderProductsImage.image = placeholderImage
                }
                print("resppp",res)
            }
        
        }

        print("pID",product.productId)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 }
    
 
}
