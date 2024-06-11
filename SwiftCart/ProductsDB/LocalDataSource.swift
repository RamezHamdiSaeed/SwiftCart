//
//  LocalDataSource.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol LocalDataSource{
    
    func getProductsFromFav()->[ProductTemp]?
    func insertProductToFav(product: ProductTemp)
    func isFav(product: ProductTemp)->Bool
    func deleteProductFromFav(product: ProductTemp)
}
