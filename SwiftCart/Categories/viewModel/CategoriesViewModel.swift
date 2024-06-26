//
//  CategoriesViewModel.swift
//  SwiftCart
//
//  Created by marwa on 29/05/2024.
//

import Foundation

protocol CategoriesViewModel {
 
    var productsClosure: ([Product]) -> Void { get set }
    func getProducts(collectionId: String)
    var rateClosure : (Double)->Void { get set }
    func getRate()
}

class CategoriesViewModelImp : CategoriesViewModel {
    private var networkService: NetworkServices
    init(networkService: NetworkServices = NetworkServicesImpl()) {
          self.networkService = networkService
      }
    
    var productsClosure : ([Product])->Void = {_ in }
    var rateClosure : (Double)->Void = {_ in }
    
    func getRate(){
        getPrice() { [weak self] rate in
            self?.rateClosure(rate)
        }
    }
    func getProducts( collectionId : String ){
        networkService.fetchProducts( collectionId: collectionId ) {[weak self] res in
            switch res {
            case .success(let response) :
                self?.productsClosure(response.products)
                print("CategoriesViewModel success")
            case .failure(let error):
                print("CategoriesViewModel error :",error.localizedDescription)
            }
        }
    }
   
   
}
