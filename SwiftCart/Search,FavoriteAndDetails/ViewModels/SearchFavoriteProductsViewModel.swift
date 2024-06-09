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
    
    var filteredProducts = BehaviorRelay<[ProductTemp]>(value: [])
    var allProducts = BehaviorRelay<[ProductTemp]>(value: [])
    
    init(networkService: SearchNetworkService) {
        self.networkService = networkService
        fetchProducts()
        setupBindings()
//        networkService.fetchProducts(fetchedProducts: { [self]
//            products in
//            self.allProducts = products
//            filteredProducts = Observable.combineLatest(
//                self.allProducts,
//                searchText.asObservable(),
//                priceRange.asObservable()
//            ) { products, searchText, priceRange in
//                print(priceRange.upperBound)
//                return products.filter { product in
//                    (searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())) &&
//                    priceRange.contains(Double(product.price) ?? 0.0)
//                }
//            }
//        })
        

    }
    private func fetchProducts() {
        networkService.fetchProducts { [weak self] products in
            guard let self = self else { return }
            print("Products fetched: \(products)")
            self.allProducts.accept(products)
            self.applyFilters()

        }
    }

    private func setupBindings() {
        Observable.combineLatest(allProducts.asObservable(), searchText.asObservable(), priceRange.asObservable())
            .subscribe(onNext: { [weak self] products, searchText, priceRange in
                guard let self = self else { return }
                print("Combining latest values")
                print("Price Range Upper Bound: \(priceRange.upperBound)")
                let filtered = products.filter { product in
                    (searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())) &&
                    priceRange.contains(Double(product.price) ?? 0.0)
                }
                print("Filtered Products: \(filtered)")
                self.filteredProducts.accept(filtered)
            })
            .disposed(by: disposeBag)
    }
    private func applyFilters() {
        let filtered = allProducts.value.filter { product in
            (searchText.value.isEmpty || product.name.lowercased().contains(searchText.value.lowercased())) &&
            priceRange.value.contains(Double(product.price) ?? 0.0)
        }
        filteredProducts.accept(filtered)
    }
//    func toggleFavorite(for product: Product) {
//    }
}
