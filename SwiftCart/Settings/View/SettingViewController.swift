//
//  SettingViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 26/05/2024.
//
//
import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var moode: UISegmentedControl!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var pullDownMenu: UIButton!

    var locationViewModel = LocationViewModel()
    var authVC: AuthViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authVC = AuthViewModelImpl()
        logout.layer.cornerRadius = 10
        setHeader(view: self, title: "Settings")
        loadSelectedCurrency()
        setupMenu()
        loadSelectedMode()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if User.id == nil {
            logout.isEnabled = false
            logout.isHidden = true
        }
    }

    @IBAction func lightDarkMode(_ sender: UISegmentedControl) {
        let selectedMode = sender.selectedSegmentIndex
        UserDefaults.standard.set(selectedMode, forKey: "selectedMode")
        applyInterfaceStyle(selectedMode)
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

    func loadSelectedMode() {
        let selectedMode = UserDefaults.standard.integer(forKey: "selectedMode")
        moode.selectedSegmentIndex = selectedMode
        applyInterfaceStyle(selectedMode)
    }

    func applyInterfaceStyle(_ selectedMode: Int) {
        let scenes = UIApplication.shared.connectedScenes
        for scene in scenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows {
                    switch selectedMode {
                    case 0:
                        window.overrideUserInterfaceStyle = .light
                    case 1:
                        window.overrideUserInterfaceStyle = .dark
                    default:
                        break
                    }
                }
            }
        }
    }

    @IBAction func LogOut(_ sender: Any) {
        
        self.authVC!.logOut(whenSuccess: nil)

        AppCommon.feedbackManager.showCancelableAlert(alertTitle: "", alertMessage: "Do you want to logout?", alertStyle: .alert, view: self, okCompletion: {
            let authenticationStoryBoard = UIStoryboard(name: "Authentication", bundle: nil)
                        let logInVC:LogInViewController = (authenticationStoryBoard.instantiateViewController(withIdentifier: "LogInViewController")) as! LogInViewController
                                self.navigationController?.pushViewController(logInVC, animated: true)
        })
    }
}
