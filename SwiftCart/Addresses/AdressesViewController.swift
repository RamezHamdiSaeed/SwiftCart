//
//  AdressesViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 10/06/2024.
//


import UIKit

class AdressesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ReloadProtocol {
    
    @IBOutlet weak var addressTable: UITableView!
    var viewModel: LocationViewModel!
    let customerId = User.id
    
    var lists:[Address] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addNibFile()
        setupViewModel()
        loadLocations()
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
            cell.phoneText.text = address.phone
            cell.zipCodeText.text = address.zip
            
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
        return 200// Adjust the height as needed
    }
}
