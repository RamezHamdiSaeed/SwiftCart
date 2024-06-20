//
//  FavoriteViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 19/06/2024.
//

import Foundation

protocol FavoriteViewModel{
    func getFavoriteProductsDB()
    func insertProductToFavDB(product: ProductTemp)
    func isProductFavorite(product: ProductTemp)->Bool
    func deleteProductFromFav(product: ProductTemp)
}
