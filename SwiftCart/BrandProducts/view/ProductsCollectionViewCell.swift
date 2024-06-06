//
//  ProductsCollectionViewCell.swift
//  SwiftCart
//
//  Created by marwa on 30/05/2024.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    var product : Product?
    var isClicked = false
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
  
    @IBOutlet weak var fillLove: UIImageView!
    
    @IBOutlet weak var emptyLove: UIImageView!
    
    @IBAction func addToFAV(_ sender: Any) {
        if !isClicked{
            emptyLove.isHidden = true
            fillLove.isHidden = false
        }else{
            emptyLove.isHidden = false
            fillLove.isHidden = true
        }
        print("Faaaaaaaaaaav")
        print(product?.title)
    }
}
