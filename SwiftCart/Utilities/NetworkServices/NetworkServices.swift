//
//  NetworkServices.swift
//  SwiftCart
//
//  Created by marwa on 16/06/2024.
//



import Foundation
protocol NetworkServices {
     func fetchBrands (completionHandler completion: @escaping (Result<SmartCollectionsResponse,Error>) -> Void)
     func fetchProducts (collectionId : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void)
     func fetchProductsForSubCategory (productType : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void)
     func fetchOrders (customerId :  String, completionHandler completion: @escaping (Result<OrdersResponse,Error>) -> Void)
    func fetchProducts (singleCollectionId : Int ,completionHandler completion: @escaping (Result<ProductResponse,Error>) -> Void)

}
class NetworkServicesImpl : NetworkServices {
    
    
     func fetchProducts (singleCollectionId : Int ,completionHandler completion: @escaping (Result<ProductResponse,Error>) -> Void){
           let urlStr = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/products.json?collection_id=\(singleCollectionId)"
    
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
    
                    let products = try json.decode(ProductResponse.self,from: data)
    
                    completion(.success(data: products))
                  //  print(products.products[0])
                   }catch let error as Error{
                       completion(.failure(error: error))
                       print("ProductsServicesImp error catch : ",error )
                }
            }
            task.resume()
        }
     func fetchProducts (collectionId : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void){
       let urlStr = "https://mad-ios-ism-2.myshopify.com//admin/api/2024-04/products.json?collection_id=\(collectionId)"
        
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
                
                let products = try json.decode(ProductsResponse.self,from: data)
              
                completion(.success(data: products))
               }catch let error as Error{
                   completion(.failure(error: error))
                   print("ProductsServicesImp error catch : ",error )
            }
        }
        task.resume()
    }
     func fetchProductsForSubCategory (productType : String ,completionHandler completion: @escaping (Result<ProductsResponse,Error>) -> Void){
       let urlStr = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/products.json?collection_id=422258901243&product_type=\(productType)"
        
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
                
                let products = try json.decode(ProductsResponse.self,from: data)
              
                completion(.success(data: products))
               }catch let error as Error{
                   completion(.failure(error: error))
                   print("ProductsServicesImp error catch : ",error )
            }
        }
        task.resume()
    }
     func fetchOrders (customerId :  String, completionHandler completion: @escaping (Result<OrdersResponse,Error>) -> Void){
       let urlStr = "https://mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/\(customerId)/orders.json"
        
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
                
                   print("fetchOrders error error")
                return
            }
            guard let data = data else {
                completion(.failure(error: error!))
                
                   print("fetchOrderss error data")
                return
            }
            do {
                var json = JSONDecoder()
                json.keyDecodingStrategy = .convertFromSnakeCase
                
                let brands = try json.decode(OrdersResponse.self,from: data)
              
                completion(.success(data: brands))
                print("fetchOrderss  : ")
               }catch let error as Error{
                   completion(.failure(error: error))
                   print("fetchOrderss error catch : ",error )
            }
        }
        task.resume()
    }
     func fetchBrands (completionHandler completion: @escaping (Result<SmartCollectionsResponse,Error>) -> Void){
       let urlStr = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/smart_collections.json"
        
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
                
                   print("fetchBrands error error")
                return
            }
            guard let data = data else {
                completion(.failure(error: error!))
                
                   print("fetchBrands error data")
                return
            }
            do {
                var json = JSONDecoder()
                json.keyDecodingStrategy = .convertFromSnakeCase
                
                let brands = try json.decode(SmartCollectionsResponse.self,from: data)
              
                completion(.success(data: brands))
                print(brands.smartCollections[0])
               }catch let error as Error{
                   completion(.failure(error: error))
                   print("fetchBrands error catch : ",error )
            }
        }
        task.resume()
    }

}
