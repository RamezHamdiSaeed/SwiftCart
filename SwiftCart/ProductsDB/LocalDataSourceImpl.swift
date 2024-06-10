//
//  LocalDataSourceImpl.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import Foundation
import UIKit
import CoreData


class LocalDataSourceImpl : LocalDataSource{
    
    public static let shared = LocalDataSourceImpl()
    private var products = [Product]()
    
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func getProductsFromFav()->[Product]?{
        do{
            products = try context!.fetch(Product.fetchRequest())
            return prepareData()
            
        }catch{
            print("error happened while retireving the data over the dataBase")
            return [League]()
        }
    }
    
    func insertProductToFav(product: SearchedProduct){
        let newProduct = Product(context: self.context!)
        newProduct.productID = product.id
        newProduct.productImage = product.image?.src
        newProduct.productPrice = product.variants.price
        newProduct.productName = product.title
        do{
            try context?.save()
        }
        catch{
            print("error happened while retireving the data over the dataBase")
            
        }
    }
    
    func deleteProductFromFav(product: SearchedProduct){
        if let index = products.firstIndex(where: { $0.productID == product.id ?? -1 }) {
            context?.delete(products[index])
            do {
                try context?.save()
            } catch {
                print("Error occurred while deleting data from the database")
            }
        }
    }
    
    func isFav(product: SearchedProduct)->Bool{
        return products.contains(where: { $0.productID == product.id ?? -1 })
    }
 
    
}
