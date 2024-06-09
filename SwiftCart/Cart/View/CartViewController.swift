//
//  CartViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 04/06/2024.
//

import UIKit

class CartViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
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

        // Do any additional setup after loading the view.
    }
    func addNibFile() {
        
        cartTable.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "cartCell")
        cartTable.dataSource = self
        cartTable.delegate = self
    }
    
  
}
