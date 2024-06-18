//
//  SearchViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var feedbackImage: UIImageView!
    var searchController: UISearchController!

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var priceSlider: UISlider!
    
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    private let viewModel: SearchFavoriteProductsViewModel = {
        
        let searchFavoriteProductsVC = SearchFavoriteProductsViewModel(networkService: SearchNetworkService())
        searchFavoriteProductsVC.fetchProducts()
        searchFavoriteProductsVC.getFavoriteProductsDB()
        return searchFavoriteProductsVC
    }()
       private let disposeBag = DisposeBag()
    
    var productViewModel = ProductsViewModel()
    var rate : Double!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productViewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        productViewModel.getRate()
        setHeader(view: self, title: "search")

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
        
        let productNibFile = UINib(nibName: "SingleProductCollectionViewCell", bundle: nil)
        productsCollectionView.register(productNibFile, forCellWithReuseIdentifier: "cell")
        
        CollectionViewDesign.collectionView(colView: productsCollectionView)

            
            if let layout = productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                layout.minimumInteritemSpacing = 10
//                layout.minimumLineSpacing = 10
                
//                let itemWidth = (productsCollectionView.bounds.width - 30) / 2
                layout.itemSize = CGSize(width: 150, height: 254)
//                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.invalidateLayout()

            }
//        CGSize(width: 150, height: 254)
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
            .map {
                
                String(format: "%.2f", convertPrice(price: String(describing: $0), rate: self.rate ?? 0 )) + " " + self.userCurrency
                
            }
            .bind(to: priceLabel.rx.text)
            .disposed(by: disposeBag)
           
               
        viewModel.filteredProducts
            .bind(to: productsCollectionView.rx.items(cellIdentifier: "cell", cellType: SingleProductCollectionViewCell.self)) { row, product, cell in
                var myProduct = product
                myProduct.isFavorite = self.viewModel.isProductFavorite(product: product)
                cell.productName.text = product.name
                if let imageUrl = URL(string: product.image) {
                    cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "processing"))
                } else {
                    cell.productImage.image = UIImage(named: "processing")
                }

                var convertedPrice = convertPrice(price: String(describing: product.price), rate: self.rate)

                cell.productPrice.text = "\(String(format: "%.2f", convertedPrice)) \(self.userCurrency)"
                CollectionViewDesign.collectionViewCell(cell: cell)
                
                cell.product = myProduct
                cell.toggleFavBtn()


            
            }
            .disposed(by: disposeBag)
        
        viewModel.filteredProducts
            .observe(on: MainScheduler.instance)
            .map { !$0.isEmpty && self.viewModel.isProductsFetchedSuccessfully.value}
            .bind(to: feedbackImage.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isProductsFetchedSuccessfully
            .observe(on: MainScheduler.instance)
            .map { !$0 }
            .bind(to: activityIndicator.rx.isAnimating)
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

