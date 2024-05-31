//
//  AdressesTableViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 26/05/2024.
//

import UIKit

class AdressesTableViewController: UITableViewController {
    var adresses : [Adresses] = []
    var viewModel = LocationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        setHeader()
        

       
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
    func setHeader(){
        let settingsLabel = UILabel()
        settingsLabel.text = "Adresses"
        settingsLabel.textColor = .systemPink
        settingsLabel.font = .boldSystemFont(ofSize: 25)
        settingsLabel.sizeToFit()
        let setting  = UIBarButtonItem (customView: settingsLabel)
        self.navigationItem.titleView = settingsLabel
        
    }

    func addButton(){
        let rightButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = rightButton

        
    }
    @objc func buttonTapped (){
        let storyboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
             if let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
                 // Pass the view model to the MapViewController
                 mapViewController.viewModel = viewModel
                 
                 let navigationController = UINavigationController(rootViewController: mapViewController)
                 
                 present(navigationController, animated: true, completion: nil)
             }
         }
    
}
    

