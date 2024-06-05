//
//  CategoriesServicesImp.swift
//  SwiftCart
//
//  Created by marwa on 29/05/2024.
//

import Foundation

//"https://{API_KEY}:{PASSWORD}@{SHOP_NAME}.myshopify.com/admin/api/2023-04/collections/{collection_id}/products.json
//"https://mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/products.json?collection_id=448684196125"
//works 
//https://47f947d8be40bd3129dbe1dbc0577a11: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@mad-ism-43-1.myshopify.com/admin/api/2023-04/products.json?collection_id=447912870180


//`~~~~~~~~~~~~~~~~
//https://mad-ios-ism-2.myshopify.com//admin/api/2024-04/products.json?collection_id=422258934011


protocol CategoriesServices {
    static func fetchProducts (collectionId : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void)
    static func fetchProductsForSubCategory (productType : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void)
}

class CategoriesServicesImp : CategoriesServices{
    
    static func fetchProducts (collectionId : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void){
       let urlStr = "https://mad-ios-ism-2.myshopify.com//admin/api/2024-04/products.json?collection_id=\(collectionId)"
        
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("ProductsServicesImp error error")
                return
            }
            guard let data = data else {
                completion(.failure(error!))
                print("ProductsServicesImp error data")
                return
            }
            do {
                var json = JSONDecoder()
                json.keyDecodingStrategy = .convertFromSnakeCase
                
                let products = try json.decode(ProductsResponse.self,from: data)
              
                completion(.success(products))
               }catch let error as Error{
                completion(.failure(error))
                   print("ProductsServicesImp error catch : ",error )
            }
        }
        task.resume()
    }
    static func fetchProductsForSubCategory (productType : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void){
       let urlStr = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/products.json?collection_id=422258901243&product_type=\(productType)"
        
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("ProductsServicesImp error error")
                return
            }
            guard let data = data else {
                completion(.failure(error!))
                print("ProductsServicesImp error data")
                return
            }
            do {
                var json = JSONDecoder()
                json.keyDecodingStrategy = .convertFromSnakeCase
                
                let products = try json.decode(ProductsResponse.self,from: data)
              
                completion(.success(products))
               }catch let error as Error{
                completion(.failure(error))
                   print("ProductsServicesImp error catch : ",error )
            }
        }
        task.resume()
    }
}
