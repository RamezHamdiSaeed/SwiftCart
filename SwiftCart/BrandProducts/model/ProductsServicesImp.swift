//
//  ProductsServicesImp.swift
//  SwiftCart
//
//  Created by marwa on 26/05/2024.
//

//"https://mad44-ism-ios1.myshopify.com/admin/api/2024-04/products.json?collection_id=\(collectionId)&access_token=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"

import Foundation

protocol ProductsServices {
    static func fetchProducts (collectionId : Int ,completionHandler completion: @escaping (Result<ProductResponse,Error>) -> Void)
}

class ProductsServicesImp : ProductsServices{
    
    static func fetchProducts (collectionId : Int ,completionHandler completion: @escaping (Result<ProductResponse,Error>) -> Void){
       let urlStr = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/products.json?collection_id=\(collectionId)"
        
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
                
                let products = try json.decode(ProductResponse.self,from: data)
              
                completion(.success(products))
              //  print(products.products[0])
               }catch let error as Error{
                completion(.failure(error))
                   print("ProductsServicesImp error catch : ",error )
            }
        }
        task.resume()
    }
}
