//
//  NewCartViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 12/06/2024.
//

import UIKit

class NewCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CartTableCellDelegate, AddressDelegate, PaymentDelegate {
    
    var rate: Double!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
    
    var cartViewModel = CartViewModel()
    var draftOrders: [DraftOrder] = []
    var lineItems: [LineItems] = []
    var customerId = User.id
    var img: String?
    var cartItemCountUpdated: ((Int) -> Void)?

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var goToPayment: UIButton!
    
    private let emptyCartBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "emptyCart")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyCartBackgroundImage()
        
        cartViewModel.rateClosure = {
            [weak self] rate in
            DispatchQueue.main.async { [self] in
                self?.rate = rate
                self?.calculateTotalPrice()
            }
        }
        cartViewModel.getRate()
        
        styleTableView(tableView: cartTable)
        setBackground(view: self.view)
        goToPayment.layer.cornerRadius = 10
        addNibFile()
        
        cartViewModel.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.draftOrders = self?.cartViewModel.result ?? []
                self?.lineItems = self?.draftOrders.flatMap { $0.lineItems ?? [] } ?? []
                self?.cartTable.reloadData()
                self?.calculateTotalPrice()
                self?.toggleEmptyCartBackground()
            }
        }
        
        cartViewModel.fetchFromCart(customerID: customerId ?? 0)
    }

    private func setupEmptyCartBackgroundImage() {
        view.addSubview(emptyCartBackgroundImageView)
        NSLayoutConstraint.activate([
            emptyCartBackgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartBackgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyCartBackgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            emptyCartBackgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        emptyCartBackgroundImageView.isHidden = true // Initially hidden
    }
    
    private func toggleEmptyCartBackground() {
        let isEmpty = lineItems.isEmpty
        emptyCartBackgroundImageView.isHidden = !isEmpty
        goToPayment.isEnabled = !isEmpty
        goToPayment.alpha = isEmpty ? 0.5 : 1.0 // Optional: to visually indicate button is disabled
    }
    
    func didCompletePurchase() {
        draftOrders = []
        lineItems = []
        cartTable.reloadData()
        calculateTotalPrice()
        toggleEmptyCartBackground()
    }

    func calculateTotalPrice() {
        let total = lineItems.reduce(0.0) { total, item in
            let itemPrice = Double(item.price ?? "") ?? 0.0
            return total + (itemPrice * Double(item.quantity ?? 0))
        }
        
        let convertedPrice = convertPrice(price: String(total), rate: self.rate)
        totalPrice.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"
        
        updateCartItemCount()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartViewModel.fetchFromCart(customerID: customerId ?? 0)
        cartViewModel.rateClosure = {
            [weak self] rate in
            DispatchQueue.main.async { [self] in
                self?.rate = rate
                self?.calculateTotalPrice()
            }
        }
        cartViewModel.getRate()
    }

    func addNibFile() {
        cartTable.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "cartCell")
        cartTable.dataSource = self
        cartTable.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return draftOrders.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return draftOrders[section].lineItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.delegate = self
        cell.contentView.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.backgroundColor = UIColor.white.cgColor

        let draftOrder = draftOrders[indexPath.section]
        if let lineItem = draftOrder.lineItems?[indexPath.row] {
            cell.configure(with: lineItem, rate: self.rate, userCurrency: self.userCurrency)
        }

        styleTableViewCell(cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let draftOrder = draftOrders[indexPath.section]
            if let draftOrderID = draftOrder.id {
                let alertController = UIAlertController(title: "Delete Item", message: "Are you sure you want to delete this item from the cart?", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    self.cartViewModel.deleteFromCart(draftOrderID: draftOrderID)
                }))
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func didChangeQuantity(cell: CartTableViewCell, quantity: Int) {
        guard let indexPath = cartTable.indexPath(for: cell) else { return }
        let draftOrder = draftOrders[indexPath.section]
        if let lineItem = draftOrder.lineItems?[indexPath.row], let draftOrderID = draftOrder.id {
            let lineItemRequest = LineItemRequest(variantID: lineItem.variantID ?? 0, quantity: quantity, imageUrl: lineItem.productImage ?? "")
            cartViewModel.updateOrder(customerID: customerId ?? 0, draftOrderID: draftOrderID, lineItem: lineItemRequest) { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        self?.cartViewModel.fetchFromCart(customerID: self?.customerId ?? 0)
                        self?.updateCartItemCount()
                        self?.toggleEmptyCartBackground()
                    }
                } else {
                    print("Failed to update quantity")
                }
            }
        }
    }

    func updateCartItemCount() {
        let itemCount = lineItems.reduce(0) { $0 + ($1.quantity ?? 0) }
        cartItemCountUpdated?(itemCount)
    }

    @IBAction func checkOut(_ sender: Any) {
        let adresses = AdressesViewController()
        adresses.delegate = self
        adresses.draftOrders = draftOrders
        self.navigationController?.pushViewController(adresses, animated: true)
    }
    
    func selectAddress(_ address: Address) {
        let paymentViewController = PaymentViewController()
        paymentViewController.selectedAddress = address
        paymentViewController.draftOrders = draftOrders
    }
}
