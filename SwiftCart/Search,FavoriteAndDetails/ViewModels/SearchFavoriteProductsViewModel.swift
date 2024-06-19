//
//  ProductsViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 02/06/2024.
//

import Foundation
import RxSwift
import RxCocoa

class SearchFavoriteProductsViewModel : FavoriteViewModel{
    
    var productsClosure : ([Product])->Void = {_ in }
    var rateClosure : (Double)->Void = {_ in }
    
    func getRate(){
        getPrice() { [weak self] rate in
            self?.rateClosure(rate)
        }
    }
    
    private let networkService: SearchNetworkService
    private let disposeBag = DisposeBag()
    
    let searchText = BehaviorRelay<String>(value: "")
    let priceRange = BehaviorRelay<ClosedRange<Double>>(value: 0...1000)
    
    var filteredProducts = BehaviorRelay<[ProductTemp]>(value: [])
    var allProducts = BehaviorRelay<[ProductTemp]>(value: [])
    var isProductsFetchedSuccessfully = BehaviorRelay<Bool>(value: false)
    var allProductsDB = BehaviorRelay<[ProductTemp]>(value: [])
    
    init(networkService: SearchNetworkService) {
        self.networkService = networkService
        
    }
     func fetchProducts() {
        networkService.fetchProducts { [weak self] products in
            guard let self = self else { return }
            self.isProductsFetchedSuccessfully.accept(true)
            print("Products fetched: \(products)")
            self.allProducts.accept(products)
            self.applyFilters()
        }
         setupBindings(allProducts: self.allProducts)
    }
    
    func setupBindings(allProducts:BehaviorRelay<[ProductTemp]>) {
        Observable.combineLatest(allProducts.asObservable(), searchText.asObservable(), priceRange.asObservable())
            .subscribe(onNext: { [weak self] products, searchText, priceRange in
                guard let self = self else { return }
                print("Combining latest values")
                print("Price Range Upper Bound: \(priceRange.upperBound)")
                let filtered = products.filter { product in
                    (searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())) &&
                    priceRange.contains(Double(product.price))
                }
                print("Filtered Products: \(filtered)")
                self.filteredProducts.accept(filtered)
            })
            .disposed(by: disposeBag)
    }
    private func applyFilters() {
        let filtered = allProducts.value.filter { product in
            (searchText.value.isEmpty || product.name.lowercased().contains(searchText.value.lowercased())) &&
            priceRange.value.contains(Double(product.price) )
        }
        filteredProducts.accept(filtered)
    }
    func getFavoriteProductsDB(){
        self.allProductsDB.accept(LocalDataSourceImpl.shared.getProductsFromFav() ?? [ProductTemp]())
        self.isProductsFetchedSuccessfully.accept(true)

    }
    func insertProductToFavDB(product: ProductTemp){
        LocalDataSourceImpl.shared.insertProductToFav(product: product)
        getFavoriteProductsDB()
    }
    func isProductFavorite(product: ProductTemp)->Bool{
        LocalDataSourceImpl.shared.isFav(product: product)
    }
    func deleteProductFromFav(product: ProductTemp){
        LocalDataSourceImpl.shared.deleteProductFromFav(product: product)
        getFavoriteProductsDB()
    }
}
