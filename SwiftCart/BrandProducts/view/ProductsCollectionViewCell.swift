//
//  ProductsCollectionViewCell.swift
//  SwiftCart
//
//  Created by marwa on 30/05/2024.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    var product : Product?
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
  
  
    
    @IBAction func addToFAV(_ sender: Any) {
        print("Faaaaaaaaaaav")
        print(product?.title)
    }
}
