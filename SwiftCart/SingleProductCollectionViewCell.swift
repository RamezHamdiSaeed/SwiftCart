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
    var viewModel = SearchFavoriteProductsViewModel(networkService: SearchNetworkService(networkingManager: NetworkingManagerImpl()))
    
    var whenRemoved : (()->())? = nil
    var whenTransactionFulfilledWithDB : ((_ message:String)->())? = nil

    var whenRemoving : (()->())? = nil
    var guestClosure : (()->())? = nil
    
    @IBAction func productAddToFavBtn(_ sender: Any) {
        guard let currentProductCell = product else {return}
        if currentProductCell.isFavorite {
            whenRemoving?()
       

        }
        else{
            if User.id == nil{
                guestClosure?()
            }else{
                viewModel.insertProductToFavDB(product: product!)
                whenTransactionFulfilledWithDB?("Product inserted into the wishlist successfully")
                favBtnOUtlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                product?.isFavorite = true
            }

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
    func okRemovingCellBtn (){
        viewModel.deleteProductFromFav(product: product!)
        whenTransactionFulfilledWithDB?("Product removed from the wishlist successfully")

        if let whenRemoved = whenRemoved {
            whenRemoved()
        }
        else {
            favBtnOUtlet.setImage(UIImage(systemName: "heart"), for: .normal)
            product?.isFavorite = false
        }
        
    }
  
}

