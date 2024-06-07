//
//  ProductsViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import Foundation
import RxSwift
import RxCocoa

class SearchFavoriteProductsViewModel {
    private let networkService: SearchNetworkService
    private let disposeBag = DisposeBag()
    
    let searchText = BehaviorRelay<String>(value: "")
    let priceRange = BehaviorRelay<ClosedRange<Double>>(value: 0...1000)
    
    var filteredProducts: Observable<[ProductTemp]> = Observable.just([ProductTemp]())
    var allProducts : Observable<[ProductTemp]> = Observable.just([ProductTemp]())
    
    init(networkService: SearchNetworkService) {
        self.networkService = networkService
        networkService.fetchProducts(fetchedProducts: { [self]
            products in
            self.allProducts = products
            filteredProducts = Observable.combineLatest(
                self.allProducts,
                searchText.asObservable(),
                priceRange.asObservable()
            ) { products, searchText, priceRange in
                print(priceRange.upperBound)
                return products.filter { product in
                    (searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())) &&
                    priceRange.contains(Double(product.price) ?? 0.0)
                }
            }
        })
        

    }
    
//    func toggleFavorite(for product: Product) {
//    }
}
