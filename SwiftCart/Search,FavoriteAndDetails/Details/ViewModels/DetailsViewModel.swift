//
//  DetailsViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 04/06/2024.
//

import Foundation
import RxSwift
import RxCocoa
class DetailsViewModel{
    private let detailsnetworkService: DetailsNetworkService
    
    var productDetails: ProductDetailsResponse?
    
    var updateView : ()->() = {}
    
    init(detailsnetworkService: DetailsNetworkService) {
                self.detailsnetworkService = detailsnetworkService

    }
    func getProductDetails(productID:String){
        detailsnetworkService.fetchProductDetails(id: productID,productsDetailsResult: {productDetails in
            
            self.productDetails = productDetails
            self.updateView()
            
        } )
    }
}
