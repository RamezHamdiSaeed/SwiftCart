//
//  DetailsViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 04/06/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UITextView!
    
    @IBOutlet weak var productImages: UICollectionView!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productSizes: UISegmentedControl!
    
    @IBOutlet weak var productColors: UISegmentedControl!
    
    @IBOutlet weak var productDetails: UITextView!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var productID : String = "8624930816251"
    var detailsViewModel : DetailsViewModel!
    var customerID = User.id
    var productimgUrl = ""
    let cartViewModel = CartViewModel()
    
    var productImagesSrcs : [String] = []
    var productCount : Int?
    
    var rate : Double!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        productImages.collectionViewLayout = layout
        cartViewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        cartViewModel.getRate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addToCartBtn.isEnabled = false
        detailsViewModel = DetailsViewModel(detailsnetworkService: DetailsNetworkService(networkingManager: NetworkingManagerImpl()))
        detailsViewModel.updateView = { [self] in
            
            
            DispatchQueue.main.async { [self] in
                let currentProduct = detailsViewModel.productDetails?.product
                self.productImage.sd_setImage(with: URL(string: (currentProduct?.image?.src)!), placeholderImage: UIImage(named: "placeholder"))
                self.productimgUrl =  currentProduct?.image?.src ?? "catImage"
                let productImages = currentProduct?.images
                
                if let productImages = productImages , productImages.count > 0{
                    for  i in 0..<(productImages.count){
                        self.productImagesSrcs.append(productImages[i].src!)
                    }
                    self.productImages.reloadData()
                }
                
                
                self.productTitle.text = currentProduct?.title
                var convertedPrice = convertPrice(price: (currentProduct?.variants![0].price)!, rate: self.rate)
                
                self.productPrice.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"
                self.productDetails.text = currentProduct?.bodyHtml
                
                // setup segment control of sizes
                self.productSizes.removeAllSegments()
                let sizes = currentProduct?.options![0].values
                for i in 0 ..< sizes!.count{
                    self.productSizes.insertSegment(withTitle: sizes![i], at: i, animated: true)
                }
                
                // setup segment control of colors
                self.productColors.removeAllSegments()
                let colors = currentProduct?.options![1].values
                for i in 0 ..< colors!.count{
                    self.productColors.insertSegment(withTitle: colors![i], at: i, animated: true)
                }
                
            }
        }
        detailsViewModel.getProductDetails(productID: self.productID)
        
        cartViewModel.rateClosure = {
            [weak self] rate in
                DispatchQueue.main.async {
                    self?.rate = rate
                }
        }
        cartViewModel.getRate()
        
    }
    func showSnackbar(message: String) {
        let snackbarHeight: CGFloat = 50.0
        let snackbar = UILabel(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: snackbarHeight))
        snackbar.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        snackbar.textColor = .white
        snackbar.textAlignment = .center
        snackbar.text = message
        snackbar.font = UIFont.systemFont(ofSize: 16)
        snackbar.alpha = 0.0
        
        view.addSubview(snackbar)
        
        UIView.animate(withDuration: 0.3, animations: {
            snackbar.frame.origin.y -= snackbarHeight
            snackbar.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseInOut, animations: {
                snackbar.frame.origin.y += snackbarHeight
                snackbar.alpha = 0.0
            }) { _ in
                snackbar.removeFromSuperview()
            }
        }
    }


    @IBAction func selectSizeSegControl(_ sender: Any) {
        let selectedSegmentIndex = ((sender as AnyObject).selectedSegmentIndex)!
        let selectedSegmentTitle = (sender as AnyObject).titleForSegment(at: selectedSegmentIndex)
        detailsViewModel.selectedOptions[0] = selectedSegmentTitle ?? ""
        detailsViewModel.filterProductVarients()
        addToCartBtn.isEnabled = detailsViewModel.selectedProductVarient != nil
        if addToCartBtn.isEnabled {
            updateView(title: (detailsViewModel.selectedProductVarient?.title)!, price: (detailsViewModel.selectedProductVarient?.price)!)
        }
    }
    @IBAction func selectColorSegControl(_ sender: Any) {
        let selectedSegmentIndex = ((sender as AnyObject).selectedSegmentIndex)!
        let selectedSegmentTitle = (sender as AnyObject).titleForSegment(at: selectedSegmentIndex)
        detailsViewModel.selectedOptions[1] = selectedSegmentTitle ?? ""
        detailsViewModel.filterProductVarients()
        addToCartBtn.isEnabled = detailsViewModel.selectedProductVarient != nil
        if addToCartBtn.isEnabled {
            updateView(title: (detailsViewModel.selectedProductVarient?.title)!, price: (detailsViewModel.selectedProductVarient?.price)!!)
        }
    }
    @IBAction func addToCartBtn(_ sender: Any) {
        guard let selectedVariant = detailsViewModel.selectedProductVarient else {
            print("No variant selected")
            return
        }
        
        let lineItem = LineItemRequest(variantID: selectedVariant.id ?? 0, quantity: 1, imageUrl: productimgUrl)
        cartViewModel.addToCart(customerId: customerID ?? 0, lineItem: lineItem)
        showSnackbar(message: "added successfully")

        print("Added 1 unit of the selected product variant to cart: \(detailsViewModel.selectedProductVarient!)")
    }

    func updateView(title:String,price:String){
        self.productTitle.text = title + " $"
        self.productPrice.text = price + " $"
    }
    
    
    @IBAction func navToReviews(_ sender: Any) {
        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
        let detailsViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "ReviewsTableViewController")) as! ReviewsTableViewController
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

extension DetailsViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImagesSrcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell
        cell!.productSingleImage.sd_setImage(with: URL(string: self.productImagesSrcs[indexPath.item]), placeholderImage: UIImage(named: "placeholder"))
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250) 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.productImage.sd_setImage(with: URL(string: self.productImagesSrcs[indexPath.item]), placeholderImage: UIImage(named: "placeholder"))
    }
}
