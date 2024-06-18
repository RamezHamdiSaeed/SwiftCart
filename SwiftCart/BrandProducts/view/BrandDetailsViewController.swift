//
//  BrandDetailsViewController.swift
//  SwiftCart
//
//  Created by marwa on 26/05/2024.


import UIKit
import SDWebImage

class BrandDetailViewController: UIViewController {
    //
    private var favViewModel: SearchFavoriteProductsViewModel!

    var price = 0.0
    @IBOutlet weak var brandProductsCollectionView: UICollectionView!
    
    var collectionIdStr: Int = 0
    var collectionTitle = ""
    var productViewModel = ProductsViewModel(networkService: NetworkServicesImpl())
    var productsArray: [Product] = []
    var rate : Double!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        productViewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        productViewModel.getRate()
        setHeader(view: self, title: collectionTitle)
        let productNibFile = UINib(nibName: "SingleProductCollectionViewCell", bundle: nil)
        brandProductsCollectionView.register(productNibFile, forCellWithReuseIdentifier: "cell")
        
        CollectionViewDesign.collectionView(colView: brandProductsCollectionView)
        brandProductsCollectionView.dataSource = self
        brandProductsCollectionView.delegate = self
        
        // Get Data of Brand's Products
        productViewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.productsArray = res
                self?.brandProductsCollectionView.reloadData()
            }
        }
        
        productViewModel.getProducts(collectionId: collectionIdStr)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productViewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.productsArray = res
                self?.brandProductsCollectionView.reloadData()
            }
        }
        
        productViewModel.getProducts(collectionId: collectionIdStr)
        
        //
       favViewModel = {
            let searchFavoriteProductsVC = SearchFavoriteProductsViewModel(networkService: SearchNetworkService())
            searchFavoriteProductsVC.getFavoriteProductsDB()
            return searchFavoriteProductsVC
        }()
    }
}

extension BrandDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SingleProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.whenRemoving = {
            AppCommon.feedbackManager.showCancelableAlert(alertTitle: "Prompt", alertMessage: "Do you want to remove from Favs", alertStyle: .alert, view: self){
                cell.okRemovingCellBtn()
            }
        }
        cell.guestClosure = {
            AppCommon.feedbackManager.showAlert(alertTitle: "Prompt", alertMessage: "You need to Log In", alertStyle: .alert, view: self)
        }
        // Configure Cell
        let product = productsArray[indexPath.item]
        cell.productName.text = product.title
        if let imageUrl = URL(string: product.image.src) {
            cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "processing"))
        } else {
            cell.productImage.image = UIImage(named: "processing")
        }

        var convertedPrice = convertPrice(price: product.variants[0].price, rate: self.rate)

        cell.productPrice.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"
        CollectionViewDesign.collectionViewCell(cell: cell)
    
        var productTemp = ProductTemp(id: product.id, name: product.title , price: Double(product.variants[0].price)!, isFavorite: false, image: product.image.src)
       //
        productTemp.isFavorite = favViewModel.isProductFavorite(product: productTemp)
        
        cell.product = productTemp
        cell.toggleFavBtn()
        

        return cell
    }
}

extension BrandDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productsArray[indexPath.item]
        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
        let detailsViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "DetailsViewController")) as! DetailsViewController
        detailsViewController.productID = String(product.id)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension BrandDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 254)
    }
}

