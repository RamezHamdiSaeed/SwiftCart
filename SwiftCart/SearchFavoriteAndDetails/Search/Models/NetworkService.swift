//
//  NetworkService.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import Foundation
import RxSwift

class NetworkService {
    
//    func fetchProducts(observalbeResult: @escaping (Observable<[Product]>) -> Void) -> Void{
        func fetchProducts() -> Observable<[ProductTemp]> {
//        AppCommon.networkingManager.networkingRequest(path: "/products.json", queryItems: nil, method: .GET, requestBody: nil, networkResponse: {
//             result in
//                switch result {
//                case .success(let productResponse):
//                    if let products = productResponse.products {
//                        observalbeResult(Observable.just(products))
//                    } else {
//                        observalbeResult(Observable.just([]))
//                    }
//                case .failure(let error):
//                    print("network fetch products error: \(error.localizedDescription)")
//                    observalbeResult(Observable.just([]))
//                }
//        })
        
        return Observable.just([
                   ProductTemp(id: "1", name: "Back Bag", price: 0.0, isFavorite: false,image: "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/8072c8b5718306d4be25aac21836ce16.jpg?v=1716706068"),
                   ProductTemp(id: "2", name: "Back Bag | Addidas", price: 2.0, isFavorite: true,image: "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/8072c8b5718306d4be25aac21836ce16.jpg?v=1716706068")
               ])
    }
}

