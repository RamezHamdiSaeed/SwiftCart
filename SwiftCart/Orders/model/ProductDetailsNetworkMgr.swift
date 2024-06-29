//
//  ProductDetailsNetworkMgr.swift
//  SwiftCart
//
//  Created by marwa on 23/06/2024.
//

import Foundation
class ProductDetailsNetworkMgr{
    static  func fetchProductsDetailsImage (singleCollectionId : String ,completionHandler completion: @escaping (Result<ProductDetailsResponse,Error>) -> Void){
        let urlStr = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/products/\(singleCollectionId).json"
 
         let url = URL(string: urlStr)
         let request = URLRequest(url: url!)
         let session = URLSession(configuration: .default)
         let task = session.dataTask(with: request) { data, response, error in
             if let error = error {
                 completion(.failure(error: error))
 
                    print("ProductsServicesImp error error")
                 return
             }
             guard let data = data else {
                 completion(.failure(error: error!))
 
                    print("ProductsServicesImp error data")
                 return
             }
             do {
                 var json = JSONDecoder()
                 json.keyDecodingStrategy = .convertFromSnakeCase
 
                 let products = try json.decode(ProductDetailsResponse.self,from: data)
 
                 completion(.success(data: products))
               //  print(products.products[0])
                }catch let error as Error{
                    completion(.failure(error: error))
                    print("ProductsServicesImp error catch : ",error )
             }
         }
         task.resume()
     }
}
