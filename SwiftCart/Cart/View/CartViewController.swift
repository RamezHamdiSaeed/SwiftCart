//
//  CartViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 04/06/2024.
//

import UIKit

class CartViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.itemImg.image = UIImage(named: "catimg")
        cell.itemName.text = "addidas tshirt"
        cell.itemPrice.text = "25 $"
        return cell
    }
    

    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var goToPayment: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        goToPayment.layer.cornerRadius = 10
        addNibFile()

        addStaticItemToCart()
    }
    
    func addStaticItemToCart() {
        let staticItem = LineItem(
            variantID: 46036212515067,
            quantity: 1,
            price: "220.00",
            title: "8 / black",
            taxable: true
        )
        
        let cartViewModel = CartViewModel()
        cartViewModel.addToCart(customerId: 7504636444923, lineItem: staticItem)
    }
    
    func addNibFile() {
        cartTable.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "cartCell")
        cartTable.dataSource = self
        cartTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130 // Adjust the height as needed
    }

    // Add margin between cells
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        cell.contentView.frame = cell.contentView.frame.inset(by: cell.contentView.layoutMargins)
    }
}
