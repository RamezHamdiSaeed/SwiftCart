//
//  SingleProductCollectionViewCell.swift
//  SwiftCart
//
//  Created by marwa on 11/06/2024.
//

import UIKit

class SingleProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favBtnOUtlet: UIButton!
    var product : ProductTemp!
    
    var viewModel = SearchFavoriteProductsViewModel(networkService: SearchNetworkService())
    
    @IBAction func productAddToFavBtn(_ sender: Any) {
        if favBtnOUtlet.isSelected{
            viewModel.deleteProductFromFav(product: product)
            FeedbackManager.successSwiftMessage(title: "prompt", body: "Product removed from the favorite successfully")
            favBtnOUtlet.imageView?.image = UIImage(systemName: "heart")
            favBtnOUtlet.isSelected = false
        }
        else{
            viewModel.insertProductToFavDB(product: product)
            FeedbackManager.successSwiftMessage(title: "prompt", body: "Product inserted intro the favorite successfully")
            favBtnOUtlet.imageView?.image = UIImage(systemName: "heart.fill")
            favBtnOUtlet.isSelected = true
        }
    }
  
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
}
