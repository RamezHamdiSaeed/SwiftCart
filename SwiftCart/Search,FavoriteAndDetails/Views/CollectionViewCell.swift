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
    var productCell : ProductTemp? = nil
    var viewModel : SearchFavoriteProductsViewModel = SearchFavoriteProductsViewModel(networkService: SearchNetworkService())
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func configure(with product: ProductTemp) {
        productCell = product
        nameLabel.text = product.name
        //priceLabel.text = "$  \(product.price)"
        
        getPrice(price: String(product.price)) { convertedPrice in
            DispatchQueue.main.async { [self] in
                let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
                priceLabel.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"
            }
        }
        
        favoriteButton.isSelected = product.isFavorite
        favoriteButton.imageView?.image = UIImage(systemName: product.isFavorite ? "heart.fill" : "heart")
        productImage.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder"))
        
    }
    
    @IBAction func favoriteToggleBtn(_ sender: Any) {
        if favoriteButton.isSelected{
            viewModel.deleteProductFromFav(product: productCell!)
            FeedbackManager.successSwiftMessage(title: "prompt", body: "Product removed from the favorite successfully")
            favoriteButton.imageView?.image = UIImage(systemName: "heart")
            favoriteButton.isSelected = false
        }
        else{
            viewModel.insertProductToFavDB(product: productCell!)
            FeedbackManager.successSwiftMessage(title: "prompt", body: "Product inserted intro the favorite successfully")
            favoriteButton.imageView?.image = UIImage(systemName: "heart.fill")
            favoriteButton.isSelected = true
        }
    }
    
}
