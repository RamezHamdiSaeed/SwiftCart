//
//  DetailsViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 04/06/2024.
//

import Foundation
class DetailsViewModel{
    private let detailsnetworkService: DetailsNetworkService
    
    var productDetails: ProductDetailsResponse?
    
    var productVarients : [ProductDetailsVariant] = []
    
    var selectedOptions : [String] = ["","",""]
    
    var selectedProductVarient : ProductDetailsVariant?
    
    var updateView : ()->() = {}
    
    init(detailsnetworkService: DetailsNetworkService) {
                self.detailsnetworkService = detailsnetworkService

    }
    var rateClosure : (Double)->Void = {_ in }
    
    func getRate(){
        getPrice() { [weak self] rate in
            self?.rateClosure(rate)
        }
    }
    
    func getProductDetails(productID:String){
        detailsnetworkService.fetchProductDetails(id: productID,productsDetailsResult: {productDetails in
            
            self.productDetails = productDetails
            self.productVarients = productDetails.product?.variants ?? []
            self.updateView()
            
        } )
    }
    
    func filterProductVarients(){
        
        var  filteredProductVariants : [ProductDetailsVariant]
            filteredProductVariants = productVarients.filter({productVarient in
                var result : Bool = false
                if(!selectedOptions[0].isEmpty){
                   result = productVarient.option1 == selectedOptions[0]
                    
                }
                if(!selectedOptions[1].isEmpty){
                   result =  result && productVarient.option2 == selectedOptions[1]
                    
                }
                if(!selectedOptions[2].isEmpty){
                   result = result && productVarient.option3 == selectedOptions[2]
                    
                }
                return result
                            
                        })
        
        if filteredProductVariants.count == 1 {
            selectedProductVarient = filteredProductVariants.first
            print("selected product variant : \(String(describing: selectedProductVarient))")
        }

    }
}

enum ProductVarientsFilterationOptions{
    case color
    case size
}
