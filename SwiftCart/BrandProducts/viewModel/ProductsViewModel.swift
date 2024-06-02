//
//  ProductsViewModel.swift
//  SwiftCart
//
//  Created by marwa on 26/05/2024.
//

import Foundation
class ProductsViewModel {
    var productsClosure : ([Product])->Void = {_ in }
   
    func getProducts( collectionId : Int ){
        ProductsServicesImp.fetchProducts( collectionId: collectionId ) {[weak self] res in
            switch res {
            case .success(let response) :
                self?.productsClosure(response.products)
                print("HomeViewMdel success")
                
            case .failure(let error):
                print("HomeViewMdel error :",error.localizedDescription)
            }
        }
    }
}
