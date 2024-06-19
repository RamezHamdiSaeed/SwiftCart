//
//  NetworkService.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 04/06/2024.
//

import Foundation
import RxSwift

class DetailsNetworkService {
    
    
    var networkingManager :NetworkingManager? = nil
    init(networkingManager : NetworkingManager){
        self.networkingManager = networkingManager
    }
    
    func fetchProductDetails(id:String,productsDetailsResult:@escaping(ProductDetailsResponse)->()){
        self.networkingManager!.networkingRequest(
            path: "/products/\(id).json",
            queryItems: nil,
            method: .GET,
            requestBody: nil, completeBaseURL: nil,
            networkResponse: { (result: Result<ProductDetailsResponse, NetworkError>) in
                switch result {
                case .success(let productDetailsResponse):
                    print(productDetailsResponse)
                    productsDetailsResult(productDetailsResponse)
                case .failure(error: let error):
                    print(error.localizedDescription)
                }
                
            })
        
    }
}
