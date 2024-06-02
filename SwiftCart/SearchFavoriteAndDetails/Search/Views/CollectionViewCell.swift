//
//  ProductCell.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func configure(with product: ProductTemp) {
        nameLabel.text = product.name
        priceLabel.text = "$\(product.price)"
        favoriteButton.isSelected = product.isFavorite
        productImage.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder"))
        
    }
}
