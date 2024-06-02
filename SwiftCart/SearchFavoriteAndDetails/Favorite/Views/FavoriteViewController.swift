//
//  FavoriteViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import UIKit

class FavoriteViewController: UIViewController, UISearchResultsUpdating  {
    
    var searchController: UISearchController!

    @IBOutlet weak var priceSlider: UISlider!
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()

    }
    
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterContentForSearchText(searchText)
    }

    func filterContentForSearchText(_ searchText: String) {
    }
    

}
