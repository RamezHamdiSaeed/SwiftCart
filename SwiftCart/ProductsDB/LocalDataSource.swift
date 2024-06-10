//
//  LocalDataSource.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol LocalDataSource{
    
    func getProductsFromFav()->[Product]?
    func insertProductToFav(product: Product)
    func isFav(league: Product)->Bool
    func deleteProductFromFav(league: Product)
//    func getProduct(index:Int)

    
}
