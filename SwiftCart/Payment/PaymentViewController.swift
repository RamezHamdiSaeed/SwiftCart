//
//  PaymentViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 12/06/2024.
//

import UIKit
import PassKit

class PaymentViewController: UIViewController {
    var selectedAddress: Address?
    var draftOrders: [DraftOrder]?
    var customerId = User.id
    var viewModel = CartViewModel()
    weak var delegate: PaymentDelegate?
    
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var validButton: UIButton!
    var viewModelDis = DiscountViewModel()
    var availableCoupons: [DiscountCodes] = []
    var rate: Double!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
    
    @IBOutlet weak var couponText: UITextField!
    var discountedTotalAmount: Decimal?
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validButton.layer.cornerRadius = 10
        appleButton.layer.cornerRadius = 10
        cashButton.layer.cornerRadius = 10

        
        viewModel.rateClosure = {
            [weak self] rate in
            DispatchQueue.main.async {
                self?.rate = rate
            }
        }
        viewModel.getRate()
        
        if let address = selectedAddress {
            print("Selected Address: \(address)")
        }
        print("Draft Orders: \(draftOrders)")
        print("Customer ID: \(customerId)")
        
        calculateAndDisplayTotalPrice()
        fetchAvailableCoupons()
    }
    
    func calculateAndDisplayTotalPrice() {
        guard let totalAmount = calculateTotalAmount() else { return }
        updateTotalLabel(with: totalAmount)
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
    
    @IBAction func validate(_ sender: Any) {
        guard let couponCode = couponText.text, !couponCode.isEmpty else {
            return
        }
        
        if let coupon = availableCoupons.first(where: { $0.code == couponCode }),
           let priceRule = viewModelDis.getPriceRule(for: coupon) {
            applyDiscount(priceRule)
            couponText.text = ""
        } else {
            showInvalidCouponAlert(message: "The entered coupon code is invalid.")
        }
    }
    
    @IBAction func buyWithApple(_ sender: Any) {
        startApplePay()
    }
    
    func completePurchase() {
        guard let draftOrders = draftOrders else { return }
        viewModel.completeDraftOrders(draftOrderIDs: draftOrders.map { $0.id ?? 0 }) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.viewModel.deleteDraftOrders(draftOrderIDs: draftOrders.map { $0.id ?? 0 }) { deleteSuccess in
                        DispatchQueue.main.async {
                            if deleteSuccess {
                                let successAlert = UIAlertController(title: "Success", message: "Your order has been completed.", preferredStyle: .alert)
                                successAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                    self?.navigateBackToHome()
                                })
                                self?.present(successAlert, animated: true, completion: nil)
                            } else {
                                let failureAlert = UIAlertController(title: "Warning", message: "Your order has been completed, but there was an issue deleting the draft orders.", preferredStyle: .alert)
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
    
    private func navigateBackToHome() {
        let storyboard1 = UIStoryboard(name: "HomeAndCategories", bundle: nil)
               let home = (storyboard1.instantiateViewController(withIdentifier: "tb") as? UITabBarController)!
        
        self.navigationController?.pushViewController(home, animated: true)
            
     
    }

    
    private func calculateTotalAmount() -> Decimal? {
        guard let draftOrders = draftOrders else { return nil }
        let totalAmount = draftOrders.reduce(Decimal(0.0)) { result, draftOrder in
            if let totalPrice = draftOrder.totalPrice, let orderTotal = Decimal(string: totalPrice) {
                return result + orderTotal
            }
            return result
        }
        return totalAmount
    }
    
    private func updateTotalLabel(with amount: Decimal) {
        viewModel.rateClosure = {
            [weak self] rate in
            DispatchQueue.main.async {
                self?.rate = rate
                let convertedPrice = convertPrice(price: String(describing: amount), rate: self?.rate ?? 0.0)
                self?.totalLabel.text = "\(String(format: "%.2f", convertedPrice)) \(self!.userCurrency)"
            }
        }
        viewModel.getRate()
    }
    
    private func applyDiscount(_ priceRule: PriceRule) {
        guard let totalAmount = calculateTotalAmount() else { return }
        guard let value = priceRule.value, let valueDecimal = Decimal(string: value) else {
            print("Price rule \(priceRule.id ?? 0) does not have a valid value.")
            return
        }
        
        var discountedTotal: Decimal
        if priceRule.value_type == "fixed_amount" {
            discountedTotal = totalAmount + valueDecimal
        } else if priceRule.value_type == "percentage" {
            let discountValue = totalAmount * (valueDecimal / 100)
            discountedTotal = totalAmount - discountValue
        } else {
            return
        }
        
        if discountedTotal < 0 {
            discountedTotal = 0
        }
        
        discountedTotalAmount = discountedTotal
        updateTotalLabel(with: discountedTotal)
    }
    
    // MARK: - Fetch Available Coupons
    private func fetchAvailableCoupons() {
        viewModelDis.getCouponsFromModel { [weak self] coupons in
            guard let self = self else { return }
            self.availableCoupons = coupons
        }
    }
    
    private func showInvalidCouponAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Coupon", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func startApplePay() {
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [.visa, .masterCard, .amex]) {
            let paymentRequest = PKPaymentRequest()
            paymentRequest.merchantIdentifier = "your.merchant.identifier"
            paymentRequest.supportedNetworks = [.visa, .masterCard, .amex]
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.countryCode = "US"
            paymentRequest.currencyCode = "USD"
            
            let totalAmount = discountedTotalAmount ?? calculateTotalAmount()
            
            if let totalAmount = totalAmount {
                let summaryItem = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(decimal: totalAmount))
                paymentRequest.paymentSummaryItems = [summaryItem]
                
                if let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
                    paymentVC.delegate = self
                    present(paymentVC, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Failed to calculate total amount for payment.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Apple Pay is not available on this device or no card is set up.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

extension PaymentViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let paymentToken = payment.token
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
            self.completePurchase()
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
