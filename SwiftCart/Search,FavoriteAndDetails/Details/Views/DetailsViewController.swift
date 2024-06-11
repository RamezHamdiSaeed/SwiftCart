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
    
    @IBOutlet weak var productRatings: UILabel!
    
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

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello details")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addToCartBtn.isEnabled = false
        detailsViewModel = DetailsViewModel(detailsnetworkService: DetailsNetworkService())
        detailsViewModel.updateView = { [self] in
            

            DispatchQueue.main.async { [self] in
                let currentProduct = detailsViewModel.productDetails?.product
                self.productImage.sd_setImage(with: URL(string: (currentProduct?.image?.src)!), placeholderImage: UIImage(named: "placeholder"))
                self.productimgUrl =  currentProduct?.image?.src ?? "catImage"

                self.productTitle.text = currentProduct?.title
                self.productPrice.text = (currentProduct?.variants![0].price)! + " $"
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
            
            let variantID = selectedVariant.id
            
            
            print("The selected product variant added to cart: \(variantID)")
            
        guard let selectedVariant = detailsViewModel.selectedProductVarient else {
                    print("No variant selected")
                    return
                }
                
        let lineItem = LineItemRequest(variantID: selectedVariant.id ?? 0, quantity: 1) // Assuming quantity is 1
        CartViewModel.shared.addToCart(customerId: customerID ?? 0, lineItem: lineItem)

        print("the selected product varient added to cart : \(detailsViewModel.selectedProductVarient!)")
    }
    func updateView(title:String,price:String){
        self.productTitle.text = title + " $"
        self.productPrice.text = price + " $"
    }
}
