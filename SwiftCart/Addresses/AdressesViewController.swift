//
//  AdressesViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 10/06/2024.
//


import UIKit

class AdressesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ReloadProtocol {
    
    @IBOutlet weak var addressTable: UITableView!
    @IBOutlet weak var add: UIButton!
    var viewModel: LocationViewModel!
    let customerId = User.id
    var draftOrders: [DraftOrder] = []
    weak var delegate: AddressDelegate?
    var lists: [Address] = []

    private let emptyAddressBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "locationImg") 
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyAddressBackgroundImage()
        addNibFile()
        setupViewModel()
        
        add.layer.cornerRadius = 10
        loadLocations()
    }

    private func setupEmptyAddressBackgroundImage() {
        view.addSubview(emptyAddressBackgroundImageView)
        NSLayoutConstraint.activate([
            emptyAddressBackgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyAddressBackgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyAddressBackgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            emptyAddressBackgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        emptyAddressBackgroundImageView.isHidden = true // Initially hidden
    }

    private func toggleEmptyAddressBackground() {
        emptyAddressBackgroundImageView.isHidden = !(viewModel.locations?.isEmpty ?? true)
    }

    func addNibFile() {
        addressTable.register(UINib(nibName: "AdressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        addressTable.dataSource = self
        addressTable.delegate = self
    }

    func setupViewModel() {
        viewModel = LocationViewModel()
        viewModel.onLocationsFetched = { [weak self] list in
            print("Lists adressssss \(list)")
            DispatchQueue.main.async {
                self?.addressTable.reloadData()
                self?.toggleEmptyAddressBackground()
            }
        }
    }

    func loadLocations() {
        viewModel.loadLocations(customerId: customerId ?? 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AdressTableViewCell
        if let address = viewModel.locations?[indexPath.row] {
            cell.countryText.text = address.country
            cell.cityText.text = address.city
            cell.addressText.text = address.address1
            // cell.phoneText.text = address.phone
            // cell.zipCodeText.text = address.zip
        }
        return cell
    }

    @IBAction func addingAddress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        if let addressSettingVC = storyboard.instantiateViewController(withIdentifier: "AddressSettingViewController") as? AddressSettingViewController {
            addressSettingVC.viewModel = viewModel
            addressSettingVC.customerId = customerId
            addressSettingVC.delegate = self
            self.present(addressSettingVC, animated: true, completion: nil)
        }
    }

    func reload() {
        loadLocations()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // Adjust the height as needed
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let address = viewModel.locations?[indexPath.row] {
            delegate?.selectAddress(address)

            let paymentViewController = PaymentViewController()
            paymentViewController.selectedAddress = address
            paymentViewController.draftOrders = draftOrders
            self.navigationController?.pushViewController(paymentViewController, animated: true)
        }
    }
}
