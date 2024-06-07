//
//  DetailsViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 04/06/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productRatings: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productSizes: UISegmentedControl!
    
    @IBOutlet weak var productColors: UISegmentedControl!
    
    @IBOutlet weak var productDetails: UITextView!
    var productID : String = "8624930816251"
    var detailsViewModel : DetailsViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello details")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailsViewModel = DetailsViewModel(detailsnetworkService: DetailsNetworkService())
        detailsViewModel.updateView = { [self] in
            

            DispatchQueue.main.async { [self] in
                productImage.sd_setImage(with: URL(string: (detailsViewModel.productDetails?.product?.image?.src)!), placeholderImage: UIImage(named: "placeholder"))
                self.productDetails.text = detailsViewModel.productDetails?.product?.bodyHtml

            }
        }
        detailsViewModel.getProductDetails(productID: self.productID)
    }

    @IBAction func selectSizeSegControl(_ sender: Any) {
    }
    @IBAction func selectColorSegControl(_ sender: Any) {
    }
    @IBAction func addToCartBtn(_ sender: Any) {
    }
}
