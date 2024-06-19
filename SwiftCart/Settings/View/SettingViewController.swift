//
//  SettingViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 26/05/2024.
//
//
//import UIKit
//
//class SettingViewController: UIViewController {
//
//
//    @IBOutlet weak var moode: UISegmentedControl!
//    @IBOutlet weak var contact: UILabel!
//    @IBOutlet weak var about: UILabel!
//    @IBOutlet weak var currency: UILabel!
//    @IBOutlet weak var address: UILabel!
//    @IBOutlet weak var logout: UIButton!
//    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
//
//    var locationViewModel = LocationViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        logout.layer.cornerRadius = 10
//        setHeader()
//        loadSelectedCurrency()
//
//
//        //  locationViewModel.fetchExchangeRate()
//        //        locationViewModel.onCurrencyChanged = { [weak self] selectedCurrency in
//        //            self?.updateCurrencyLabel()
//        //        }
//        //
//        //        locationViewModel.onExchangeRatesFetched = { [weak self] in
//        //            self?.updateCurrencyLabel()
//        //        }
//        //    }
//    }
//
//    func setHeader() {
//        let settingsLabel = UILabel()
//        settingsLabel.text = "Settings"
//        settingsLabel.textColor = .systemPink
//        settingsLabel.font = .boldSystemFont(ofSize: 25)
//        settingsLabel.sizeToFit()
//        self.navigationItem.titleView = settingsLabel
//    }
//
//    @IBAction func navigateToAdresses(_ sender: Any) {
////        if let adressesViewController = (storyboard?.instantiateViewController(withIdentifier: "AdressesViewController")) as? AdressesViewController {
////            self.navigationController?.pushViewController(adressesViewController, animated: true)
//            let addresses = AdressesViewController()
//                   self.navigationController?.pushViewController(addresses, animated: true)
//       // }
//    }
//
//    @IBAction func navigateToAboutUs(_ sender: Any) {
//        if let aboutUsViewController = (storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController")) as? AboutUsViewController {
//            self.navigationController?.pushViewController(aboutUsViewController, animated: true)
//            print("button tapped")
//        }
//    }
//
//    @IBAction func handleCurrency(_ sender: UISegmentedControl) {
//        let selectedSegmentIndex = sender.selectedSegmentIndex
//        let selectedCurrencyCode = selectedSegmentIndex == 0 ? "USD" : "EGP"
//        print("Selected currency: \(selectedCurrencyCode)")
//     //   locationViewModel.changeCurrency(to: selectedCurrencyCode)
//    }
//
////    private func updateCurrencyLabel() {
////        DispatchQueue.main.async {
////            if let selectedCurrency = self.locationViewModel.selectedCurrency {
////                self.currency.text = selectedCurrency.code
////                print("Currency label updated to: \(selectedCurrency.code)")
////            } else {
////                self.currency.text = "Currency"
////                print("No currency selected")
////            }
////        }
////    }
//
//
//
////    @IBAction func currencySegmentedBtn(_ sender: UISegmentedControl) {
////        switch sender.selectedSegmentIndex{
////        case 0 :
////            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.usd.rawValue)
////        case 1 :
////            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.egp.rawValue)
////        default:
////            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.usd.rawValue)
////        }
////    }
////
//
//
//    @IBAction func usdBtn(_ sender: Any) {
//            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.usd.rawValue)
//            loadSelectedCurrency()
//        }
//
//        @IBAction func egpBtn(_ sender: Any) {
//            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.egp.rawValue)
//            loadSelectedCurrency()
//        }
//
//        func loadSelectedCurrency() {
//            let selectedCurrency = CurrencyImp.getCurrencyFromUserDefaults()
//            currencySegmentedControl.selectedSegmentIndex = (selectedCurrency == "usd") ? 0 : 1
//            print("Loaded currency: \(selectedCurrency)")
//        }
//
//}

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var moode: UISegmentedControl!

    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var logout: UIButton!


    @IBOutlet weak var pullDownMenu: UIButton!

    var locationViewModel = LocationViewModel()
    var authVC : AuthViewModel?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        authVC = AuthViewModelImpl()
        logout.layer.cornerRadius = 10
        setHeader(view: self, title: "Settings")
        loadSelectedCurrency()
        setupMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // check if the user is signed in or as a guest to show or hide the logout button
        if User.id == nil   {
            logout.isEnabled = false
            logout.isHidden = true
        }
    }


    @IBAction func navigateToAdresses(_ sender: Any) {
        let addresses = AdressesViewController()
        self.navigationController?.pushViewController(addresses, animated: true)
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
    }



    func loadSelectedCurrency() {
        let selectedCurrency = CurrencyImp.getCurrencyFromUserDefaults()
        currency.text = "Selected currency: \(selectedCurrency)"
        print("Loaded currency: \(selectedCurrency)")
    }



    func setupMenu() {
        let usd = UIAction(title: "USD", image: UIImage(systemName: "dollarsign")) { [self] _ in
            print("usd")
            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.usd.rawValue)
            loadSelectedCurrency()

        }

        let egp = UIAction(title: "EGP", image: UIImage(systemName: "banknote")) { [self] _ in
            print("egp")
            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.egp.rawValue)
            loadSelectedCurrency()
        }

        let eur = UIAction(title: "EUR", image: UIImage(systemName: "eurosign")) { [self] _ in
             print("eur")
            CurrencyImp.saveCurrencyToUserDefaults(coin: Coins.eur.rawValue)
            loadSelectedCurrency()
        }

        let menu = UIMenu(title: "Menu", children: [usd, egp, eur])
        pullDownMenu.menu = menu
        pullDownMenu.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func LogOut(_ sender: Any) {
        self.authVC!.logOut(whenSuccess: nil)
        AppCommon.userSessionManager.setIsSignedOutUser()
        AppCommon.feedbackManager.showCancelableAlert(alertTitle: "Prompt", alertMessage: "Do you want to log out?", alertStyle: .alert, view: self, okCompletion: {
            let authenticationStoryBoard = UIStoryboard(name: "Authentication", bundle: nil)
            if let MainAuthViewController = (authenticationStoryBoard.instantiateViewController(withIdentifier: "MainAuthViewController")) as? MainAuthViewController {
                self.navigationController?.pushViewController(MainAuthViewController, animated: true)
                print("button tapped")
            }
        })
       
    }
    
}
