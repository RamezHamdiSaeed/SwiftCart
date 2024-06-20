//
//  NetworkService.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import Foundation
import RxSwift

class SearchNetworkService {
    
    var networkingManager :NetworkingManager? = nil
    init(networkingManager : NetworkingManager){
        self.networkingManager = networkingManager
    }
    
    var products  : Observable<[ProductTemp]> = Observable.just([ProductTemp]())
    
    func fetchProducts(fetchedProducts: @escaping ([ProductTemp]) -> Void) {
        self.networkingManager!.networkingRequest(
            path: "/products.json",
            queryItems: nil,
            method: .GET,
            requestBody: nil, completeBaseURL: nil,
            networkResponse: { (result: Result<SearchedProductsResponse, NetworkError>) in
                switch result {
                case .success(let searchedProductsResponse):
                    print("search products count \(String(describing: searchedProductsResponse.products?.count))")
                    
                    var fetchedProductsOverTheNetwork: [ProductTemp] = []
                    
                    if let products = searchedProductsResponse.products {
                        for product in products {
                             let id = product.id
                               let title = product.title
                               let price = product.variants?.first?.price
                                let imageSrc = product.image?.src
                            let productTemp = ProductTemp(id: id!, name: title!, price: Double(price!)!, isFavorite: false, image: imageSrc!)
                                fetchedProductsOverTheNetwork.append(productTemp)
                            
                        }
                    }
                    
                    fetchedProducts(fetchedProductsOverTheNetwork)
                case .failure(let error):
                    print("network fetch products error: \(error.localizedDescription)")
                }
            }
        )
    }

}

