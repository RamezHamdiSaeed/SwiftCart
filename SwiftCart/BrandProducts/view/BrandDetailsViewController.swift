//
//  BrandDetailsViewController.swift
//  SwiftCart
//
//  Created by marwa on 26/05/2024.


import UIKit
import SDWebImage

class BrandDetailViewController: UIViewController, UISearchBarDelegate {
    private var favViewModel: SearchFavoriteProductsViewModel!
    private var filteredProductsArray: [Product] = []
    private var isSearching = false

    var price = 0.0
    @IBOutlet weak var brandProductsCollectionView: UICollectionView!
   
    var collectionIdStr: Int = 0
    var collectionTitle = ""
    var productViewModel = ProductsViewModel(networkService: NetworkServicesImpl())
    var productsArray: [Product] = []
    var rate: Double!
    @IBOutlet weak var emptyImage: UIImageView!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
    
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "Search in \(collectionTitle)"
        self.navigationItem.titleView = searchBar
        
        productViewModel.rateClosure = { [weak self] rate in
            DispatchQueue.main.async {
                self?.rate = rate
            }
        }
        productViewModel.getRate()
        
        let productNibFile = UINib(nibName: "SingleProductCollectionViewCell", bundle: nil)
        brandProductsCollectionView.register(productNibFile, forCellWithReuseIdentifier: "cell")
        
        CollectionViewDesign.collectionView(colView: brandProductsCollectionView)
        brandProductsCollectionView.dataSource = self
        brandProductsCollectionView.delegate = self
        
        productViewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.productsArray = res
                self?.brandProductsCollectionView.reloadData()
                self?.checkEmpty()
            }
        }
        
        productViewModel.getProducts(collectionId: collectionIdStr)
        checkEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productViewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.productsArray = res
                self?.brandProductsCollectionView.reloadData()
                self?.checkEmpty()
            }
        }
        
        productViewModel.getProducts(collectionId: collectionIdStr)
        
        favViewModel = {
            let searchFavoriteProductsVC = SearchFavoriteProductsViewModel(networkService: SearchNetworkService(networkingManager: NetworkingManagerImpl()))
            searchFavoriteProductsVC.getFavoriteProductsDB()
            return searchFavoriteProductsVC
        }()
        
        checkEmpty()
    }
    
    // UISearchBarDelegate method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            brandProductsCollectionView.reloadData()
        } else {
            isSearching = true
            filteredProductsArray = productsArray.filter { product in
                return product.title.lowercased().contains(searchText.lowercased())
            }
            brandProductsCollectionView.reloadData()
        }
        checkEmpty()
    }
    
    func checkEmpty() {
        if isSearching {
            emptyImage.isHidden = !filteredProductsArray.isEmpty
        } else {
            emptyImage.isHidden = !productsArray.isEmpty
        }
    }
}

extension BrandDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredProductsArray.count : productsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SingleProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.whenTransactionFulfilledWithDB = {
            message in
            self.showSnackbar(message: message)
        }
        cell.whenRemoving = {
            AppCommon.feedbackManager.showCancelableAlert(alertTitle: "", alertMessage: "Do you want to remove from wishlist", alertStyle: .alert, view: self) {
                cell.okRemovingCellBtn()
            }
        }
        cell.guestClosure = {
            AppCommon.feedbackManager.showAlert(alertTitle: "", alertMessage: "You need to Login", alertStyle: .alert, view: self)
        }
        
        let product = isSearching ? filteredProductsArray[indexPath.item] : productsArray[indexPath.item]
        cell.productName.text = product.title
        if let imageUrl = URL(string: product.image.src) {
            cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "processing"))
        } else {
            cell.productImage.image = UIImage(named: "processing")
        }

        let convertedPrice = convertPrice(price: product.variants[0].price, rate: self.rate)
        cell.productPrice.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"
        CollectionViewDesign.collectionViewCell(cell: cell)
    
        var productTemp = ProductTemp(id: product.id, name: product.title, price: Double(product.variants[0].price)!, isFavorite: false, image: product.image.src)
        productTemp.isFavorite = favViewModel.isProductFavorite(product: productTemp)
        
        cell.product = productTemp
        cell.toggleFavBtn()
        
        return cell
    }
}

extension BrandDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = isSearching ? filteredProductsArray[indexPath.item] : productsArray[indexPath.item]
        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
        let detailsViewController = productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.productID = String(product.id)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension BrandDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 254)
    }
}
