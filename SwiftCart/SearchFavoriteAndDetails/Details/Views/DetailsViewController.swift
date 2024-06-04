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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func selectSizeSegControl(_ sender: Any) {
    }
    @IBAction func selectColorSegControl(_ sender: Any) {
    }
    @IBAction func addToCartBtn(_ sender: Any) {
    }
}
