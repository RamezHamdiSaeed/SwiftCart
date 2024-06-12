//
//  SingleProductCollectionViewCell.swift
//  SwiftCart
//
//  Created by marwa on 11/06/2024.
//

import UIKit

class SingleProductCollectionViewCell: UICollectionViewCell {

    var product : Product!
    @IBAction func productAddToFavBtn(_ sender: Any) {
        
    }
  
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
}
