//
//  NetworkService.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import Foundation
import RxSwift

class SearchNetworkService {
    
    var products  : Observable<[ProductTemp]> = Observable.just([ProductTemp]())
    
    func fetchProducts(fetchedProducts: @escaping (Observable<[ProductTemp]>) -> Void) {
        AppCommon.networkingManager.networkingRequest(
            path: "/products.json",
            queryItems: [URLQueryItem(name: "limit", value: "10")],
            method: .GET,
            requestBody: nil,
            networkResponse: { (result: Result<SearchedProductsResponse, NetworkError>) in
                switch result {
                case .success(let searchedProductsResponse):
                    //print(searchedProductsResponse.products ?? [])
                    
                    var fetchedProductsOverTheNetwork: [ProductTemp] = []
                    
                    if let products = searchedProductsResponse.products {
                        for product in products {
                            if let id = product.id,
                               let title = product.title,
                               let price = product.variants?.first?.price {
                                let imageSrc = product.image?.src
                                let productTemp = ProductTemp(id: id, name: title, price: price, isFavorite: false, image: imageSrc!)
                                fetchedProductsOverTheNetwork.append(productTemp)
                            }
                        }
                    }
                    
                    fetchedProducts(Observable.just(fetchedProductsOverTheNetwork))
                case .failure(let error):
                    print("network fetch products error: \(error.localizedDescription)")
                }
            }
        )
    }

}

