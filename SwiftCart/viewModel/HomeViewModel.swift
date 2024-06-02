//
//  HomeViewMdel.swift
//  SwiftCart
//
//  Created by marwa on 24/05/2024.
//

import Foundation
class HomeViewModel {
    var brandsClosure : ([SmartCollection])->Void = {_ in }
    
    func getBrands (){
        BrandService.fetchBrands { [weak self] res in
            switch res {
            case .success(let response) :
                self?.brandsClosure(response.smartCollections)
                print("HomeViewMdel success")
                
            case .failure(_):
                print("HomeViewMdel error")
        
            }
        }
    }
}
