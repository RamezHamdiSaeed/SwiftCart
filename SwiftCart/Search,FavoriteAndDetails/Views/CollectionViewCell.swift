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
    var viewModel : SearchFavoriteProductsViewModel = SearchFavoriteProductsViewModel(networkService: SearchNetworkService(networkingManager: NetworkingManagerImpl()))
    var rate : Double!
    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults().uppercased()
    var whenRemoved : (()->())? = nil

    
    func configure(with product: ProductTemp) {
        productCell = product
        nameLabel.text = product.name
        
        viewModel.rateClosure = {
            [self] rate in
                DispatchQueue.main.async {
                    self.rate = rate
                    
                    var convertedPrice = convertPrice(price: String(product.price), rate: self.rate)
                    self.priceLabel.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"
                }
        }
        viewModel.getRate()

        let imageName = product.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        productImage.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder"))
        
    }
    
    @IBAction func favoriteToggleBtn(_ sender: Any) {
        guard let currentProductCell = productCell else {return}
        if currentProductCell.isFavorite {
            print(productCell?.isFavorite)
            viewModel.deleteProductFromFav(product: productCell!)
            FeedbackManager.successSwiftMessage(title: "", body: "Product removed from the favorite successfully")
            if let whenRemoved = whenRemoved {
                whenRemoved()
            }
            else {
                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                productCell?.isFavorite = false
            }

        }
        else{
            viewModel.insertProductToFavDB(product: productCell!)
            FeedbackManager.successSwiftMessage(title: "", body: "Product inserted into the favorite successfully")
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            productCell?.isFavorite = true
        }
    }
    
}
