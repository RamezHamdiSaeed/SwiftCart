//
//  FavoriteViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    var searchController: UISearchController!

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var priceSlider: UISlider!
    
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    private let viewModel: SearchFavoriteProductsViewModel = {
        
        let searchFavoriteProductsVC = SearchFavoriteProductsViewModel(networkService: SearchNetworkService())
        searchFavoriteProductsVC.getFavoriteProductsDB()
        searchFavoriteProductsVC.setupBindings(allProducts: searchFavoriteProductsVC.allProductsDB)
        return searchFavoriteProductsVC
    }()
       private let disposeBag = DisposeBag()
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupCollectionView()
        setupBindings()



    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
   
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func setupCollectionView() {
            
            if let layout = productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumInteritemSpacing = 10
                layout.minimumLineSpacing = 10
                
                let itemWidth = (productsCollectionView.bounds.width - 30) / 2
                layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 2)
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.invalidateLayout()

            }
        }
    private func setupBindings() {
        searchController.searchBar.rx.text.orEmpty
               .bind(to: viewModel.searchText)
               .disposed(by: disposeBag)
           
           priceSlider.rx.value
            .map { Double(0.0)...Double($0) }
               .bind(to: viewModel.priceRange)
               .disposed(by: disposeBag)
        
        priceSlider.rx.value
            .map { String(format: "%.2f", $0) }
            .bind(to: priceLabel.rx.text)
            .disposed(by: disposeBag)
           
               
        viewModel.filteredProducts
            .bind(to: productsCollectionView.rx.items(cellIdentifier: "CollectionViewCell", cellType: CollectionViewCell.self)) { row, product, cell in
                var myProduct = product
                myProduct.isFavorite = self.viewModel.isProductFavorite(product: product)
                cell.configure(with: myProduct)
            }
            .disposed(by: disposeBag)
        
           productsCollectionView.rx.modelSelected(ProductTemp.self)
               .subscribe(onNext: { [weak self] product in
                           let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
                   let detailsViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "DetailsViewController")) as! DetailsViewController
                   detailsViewController.productID = String(product.id)
                   self?.navigationController?.pushViewController(detailsViewController, animated: true)
               })
               .disposed(by: disposeBag)
       }

}
