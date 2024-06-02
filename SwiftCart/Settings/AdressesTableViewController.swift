// AdressesTableViewController.swift
// SwiftCart
//
// Created by rwan elmtary on 26/05/2024.
//

import UIKit

class AdressesTableViewController: UITableViewController {
    var adresses: [Adresses] = []
    var viewModel = LocationViewModel()
    let customerId = 7504636444923
    let email = "ramez12.cetta@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        setHeader()
        
        viewModel.onLocationsFetched = { [weak self] in
            self?.adresses = self?.viewModel.locations ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.loadLocations(customerId: customerId)
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adresses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adresscell", for: indexPath)
        let adress = adresses[indexPath.row]
        cell.textLabel?.text = adress.name
        return cell
    }

    func setHeader() {
        let settingsLabel = UILabel()
        settingsLabel.text = "Addresses"
        settingsLabel.textColor = .systemPink
        settingsLabel.font = .boldSystemFont(ofSize: 25)
        settingsLabel.sizeToFit()
        self.navigationItem.titleView = settingsLabel
    }

    func addButton() {
        let rightButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc func buttonTapped() {
        let storyboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        if let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            mapViewController.viewModel = viewModel
            mapViewController.customerId = customerId
            mapViewController.email = email
            let navigationController = UINavigationController(rootViewController: mapViewController)
            present(navigationController, animated: true, completion: nil)
        }
    }
}
