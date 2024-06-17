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
    var whenRemoved : (()->())? = nil
    
    @IBAction func productAddToFavBtn(_ sender: Any) {
        guard let currentProductCell = product else {return}
        if currentProductCell.isFavorite {
            viewModel.deleteProductFromFav(product: product!)
            FeedbackManager.successSwiftMessage(title: "prompt", body: "Product removed from the favorite successfully")
            if let whenRemoved = whenRemoved {
                whenRemoved()
            }
            else {
                favBtnOUtlet.setImage(UIImage(systemName: "heart"), for: .normal)
                product?.isFavorite = false
            }

        }
        else{
            viewModel.insertProductToFavDB(product: product!)
            FeedbackManager.successSwiftMessage(title: "prompt", body: "Product inserted into the favorite successfully")
            favBtnOUtlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            product?.isFavorite = true
        }
        
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    func toggleFavBtn(){
        let imageName = product.isFavorite ? "heart.fill" : "heart"
        favBtnOUtlet.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
  
}
