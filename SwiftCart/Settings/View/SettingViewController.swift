//
//  SettingViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 26/05/2024.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var moode: UISegmentedControl!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
    
    var locationViewModel = LocationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        logout.layer.cornerRadius = 10
        setHeader()

      //  locationViewModel.fetchExchangeRate()
        locationViewModel.onCurrencyChanged = { [weak self] selectedCurrency in
            self?.updateCurrencyLabel()
        }

        locationViewModel.onExchangeRatesFetched = { [weak self] in
            self?.updateCurrencyLabel()
        }
    }
    
    func setHeader() {
        let settingsLabel = UILabel()
        settingsLabel.text = "Settings"
        settingsLabel.textColor = .systemPink
        settingsLabel.font = .boldSystemFont(ofSize: 25)
        settingsLabel.sizeToFit()
        self.navigationItem.titleView = settingsLabel
    }
    
    @IBAction func navigateToAdresses(_ sender: Any) {
        if let adressesViewController = (storyboard?.instantiateViewController(withIdentifier: "AdressesTableViewController")) as? AdressesTableViewController {
            self.navigationController?.pushViewController(adressesViewController, animated: true)
        }
    }
    
    @IBAction func navigateToAboutUs(_ sender: Any) {
	        if let aboutUsViewController = (storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController")) as? AboutUsViewController {
            self.navigationController?.pushViewController(aboutUsViewController, animated: true)
            print("button tapped")
        }
    }
    
    @IBAction func handleCurrency(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        let selectedCurrencyCode = selectedSegmentIndex == 0 ? "USD" : "EGP"
        print("Selected currency: \(selectedCurrencyCode)")
     //   locationViewModel.changeCurrency(to: selectedCurrencyCode)
    }

    private func updateCurrencyLabel() {
        DispatchQueue.main.async {
            if let selectedCurrency = self.locationViewModel.selectedCurrency {
                self.currency.text = selectedCurrency.code
                print("Currency label updated to: \(selectedCurrency.code)")
            } else {
                self.currency.text = "Currency"
                print("No currency selected")
            }
        }
    }
}
