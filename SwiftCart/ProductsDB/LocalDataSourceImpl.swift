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
    private var products = [ProductDB]()
    
    private init(){}
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func getProductsFromFav()->[ProductTemp]?{
        do{
            products = try context!.fetch(ProductDB.fetchRequest())
            return prepareData()
            
        }catch{
            print("error happened while retireving the data over the dataBase")
            return [ProductTemp]()
        }
    }
    
    func insertProductToFav(product: ProductTemp){
        let newProduct = ProductDB(context: self.context!)
        newProduct.productID = Int64(product.id)
        newProduct.productImage = product.image
        newProduct.productPrice = product.price
        newProduct.productName = product.name
        do{
            try context?.save()
        }
        catch{
            print("error happened while retireving the data over the dataBase")
            
        }
    }
    
    func deleteProductFromFav(product: ProductTemp){
        if let index = products.firstIndex(where: { $0.productID == product.id }) {
            context?.delete(products[index])
            do {
                try context?.save()
            } catch {
                print("Error occurred while deleting data from the database")
            }
        }
    }
    
    func isFav(product: ProductTemp)->Bool{
        return products.contains(where: { $0.productID == product.id ?? -1 })
    }
    
    func prepareData()->[ProductTemp]{
        
        var preparedProducts = [ProductTemp]()
        
        for item in  0..<self.products.count{
            
            let productItem = ProductTemp(id: Int(products[item].productID), name: String(products[item].productName!), price: products[item].productPrice, isFavorite: true, image: products[item].productImage!)
//            SearchedProduct(id:item.productID,image:SearchedProductImage(src:item.productImage),name:item.productName,variants:[SearchedProductVariant(price:item.productPrice)])
            
            preparedProducts.append(productItem)
        }
        return preparedProducts
    }
 
    
}
