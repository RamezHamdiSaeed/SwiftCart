//
//  DetailsViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 04/06/2024.
//

import Foundation

class DetailsViewModel{
    private let networkService: NetworkService
    private let disposeBag = DisposeBag()
    
    let searchText = BehaviorRelay<String>(value: "")
    let priceRange = BehaviorRelay<ClosedRange<Double>>(value: 0...100)
    
    let filteredProducts: Observable<[ProductTemp]>
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        
        let allProducts = networkService.fetchProducts()
        
        filteredProducts = Observable.combineLatest(
            allProducts,
            searchText.asObservable(),
            priceRange.asObservable()
        ) { products, searchText, priceRange in
            return products.filter { product in
                product.name.lowercased().contains(searchText.lowercased()) &&
                priceRange.contains(product.price)
            }
        }
    }
}
