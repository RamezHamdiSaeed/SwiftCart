//
//  CategoriesViewController.swift
//  SwiftCart
//
//  Created by marwa on 30/05/2024.
//
/*
import UIKit
import JJFloatingActionButton

class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var categoryProductsArray: [Product] = []
    var allProductsArray: [Product] = []
    var filteredProductsArray: [Product] = []
    var viewModel: CategoriesViewModel!
    let actionButton = JJFloatingActionButton()
    
    @IBOutlet weak var categorySigmentedButton: UISegmentedControl!
    @IBOutlet weak var singleCategoryProducts: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayFloatingButton()
        CollectionViewDesign.collectionView(colView: singleCategoryProducts)
        viewModel = CategoriesViewModelImp()
        singleCategoryProducts.dataSource = self
        singleCategoryProducts.delegate = self
        // Fetch initial data
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
    }
    
    func fetchProducts() {
        viewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.allProductsArray = res
                self?.categoryProductsArray = res
                self?.filterProducts()
            }
        }
        viewModel.getProducts(collectionId: getCategoryName())
    }
    
    func filterProducts() {
        if filteredProductsArray.isEmpty {
            categoryProductsArray = allProductsArray
        } else {
            categoryProductsArray = filteredProductsArray
        }
        singleCategoryProducts.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryProductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductsCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        
        let product = categoryProductsArray[indexPath.item]
        cell.productName.text = product.title
        if let imageUrl = URL(string: product.image.src) {
            cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "catimg"))
        } else {
            cell.productImage.image = UIImage(named: "catimg")
        }
        cell.productPrice.text = " \(product.variants[0].price ?? "0.0") EGP "
        
        CollectionViewDesign.collectionViewCell(cell: cell)
        cell.product = product
        
        return cell
    }
    
    func getCategoryName() -> String {
        switch self.categorySigmentedButton.selectedSegmentIndex {
            case 0: return Categories.Kids.rawValue
            case 1: return Categories.Men.rawValue
            case 2: return Categories.Women.rawValue
            case 3: return Categories.Sale.rawValue
            default: return ""
        }
    }
    
    @IBAction func segButtonAction(_ sender: UISegmentedControl) {

        filteredProductsArray.removeAll()
        fetchProducts()
    }
    
    func displayFloatingButton() {
        actionButton.buttonColor = UIColor.systemPink
        actionButton.buttonImage = UIImage(named: "menu")
        
        actionButton.addItem(title: "Shoes", image: UIImage(named: "shoes")?.withRenderingMode(.alwaysTemplate)) { [weak self] item in
            self?.filterSubCategoryProducts(by: "SHOES")
        }
        
        actionButton.addItem(title: "T-Shirts", image: UIImage(named: "tshirt")?.withRenderingMode(.alwaysTemplate)) { [weak self] item in
            self?.filterSubCategoryProducts(by: "T-SHIRTS")
        }
        
        actionButton.addItem(title: "Accessories", image: UIImage(named: "jewelry")?.withRenderingMode(.alwaysTemplate)) { [weak self] item in
            self?.filterSubCategoryProducts(by: "ACCESSORIES")
        }
        
        actionButton.display(inViewController: self)
    }
    
    func filterSubCategoryProducts(by subCategory: String) {
        filteredProductsArray = allProductsArray.filter { $0.productType == subCategory }
        categoryProductsArray = filteredProductsArray
        singleCategoryProducts.reloadData()
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 254)
    }
}
*/
import UIKit
import JJFloatingActionButton

class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var favViewModel: SearchFavoriteProductsViewModel!

    
    var categoryProductsArray: [Product] = []
    var allProductsArray: [Product] = []
    var filteredProductsArray: [Product] = []
    var viewModel: CategoriesViewModel!
    let actionButton = JJFloatingActionButton()
    var rate : Double!
    var userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
    
    @IBOutlet weak var bascketImage: UIImageView!
    @IBOutlet weak var categorySigmentedButton: UISegmentedControl!
    @IBOutlet weak var singleCategoryProducts: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CategoriesViewModelImp()
        viewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        viewModel.getRate()
        setHeader(view: self, title: "Category")
        var productNibFile = UINib(nibName: "SingleProductCollectionViewCell", bundle: nil)
        singleCategoryProducts.register(productNibFile, forCellWithReuseIdentifier: "cell")
        
        displayFloatingButton()
        CollectionViewDesign.collectionView(colView: singleCategoryProducts)
        singleCategoryProducts.dataSource = self
        singleCategoryProducts.delegate = self
        fetchProducts()
        
        //
       favViewModel = {
            let searchFavoriteProductsVC = SearchFavoriteProductsViewModel(networkService: SearchNetworkService())
            searchFavoriteProductsVC.getFavoriteProductsDB()
            return searchFavoriteProductsVC
        }()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
        viewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        viewModel.getRate()
        userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
        
     

    }
    
    func fetchProducts() {
        viewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.allProductsArray = res
                self?.categoryProductsArray = res
                self?.filterProducts()
                self?.bascketImage.isHidden = true
            }
        }
        viewModel.getProducts(collectionId: getCategoryName())
    }
    
    func filterProducts() {
        if filteredProductsArray.isEmpty {
            categoryProductsArray = allProductsArray
        } else {
            categoryProductsArray = filteredProductsArray
        }
        singleCategoryProducts.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryProductsArray.count
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
        
        let product = categoryProductsArray[indexPath.item]
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

         productTemp.isFavorite = favViewModel.isProductFavorite(product: productTemp)
         
         cell.product = productTemp
 
         cell.toggleFavBtn()
         
        return cell
    }
    
    func getCategoryName() -> String {
        switch self.categorySigmentedButton.selectedSegmentIndex {
            case 0: return Categories.Kids.rawValue
            case 1: return Categories.Men.rawValue
            case 2: return Categories.Women.rawValue
            case 3: return Categories.Sale.rawValue
            default: return ""
        }
    }
    
    @IBAction func segButtonAction(_ sender: UISegmentedControl) {
        filteredProductsArray.removeAll()
        fetchProducts()
    }
    
    func displayFloatingButton() {
        actionButton.buttonColor = UIColor.systemOrange
        actionButton.buttonImage = UIImage(named: "menu")
        
        actionButton.addItem(title: "Shoes", image: UIImage(named: "shoes")?.withRenderingMode(.alwaysTemplate)) { [weak self] item in
            self?.filterSubCategoryProducts(by: "SHOES")
        }
        
        actionButton.addItem(title: "T-Shirts", image: UIImage(named: "tshirt")?.withRenderingMode(.alwaysTemplate)) { [weak self] item in
            self?.filterSubCategoryProducts(by: "T-SHIRTS")
        }
        
        actionButton.addItem(title: "Accessories", image: UIImage(named: "jewelry")?.withRenderingMode(.alwaysTemplate)) { [weak self] item in
            self?.filterSubCategoryProducts(by: "ACCESSORIES")
        }
        
        actionButton.display(inViewController: self)
    }
    
    func filterSubCategoryProducts(by subCategory: String) {
        filteredProductsArray = allProductsArray.filter { $0.productType == subCategory }
        categoryProductsArray = filteredProductsArray
        singleCategoryProducts.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let product = categoryProductsArray[indexPath.item]
            let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
            let detailsViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "DetailsViewController")) as! DetailsViewController
            detailsViewController.productID = String(product.id)
            self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}


