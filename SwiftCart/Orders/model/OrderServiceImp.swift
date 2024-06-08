//
//  OrderServiceImp.swift
//  SwiftCart
//
//  Created by marwa on 07/06/2024.
//

import Foundation
protocol OrdersService{
    static func fetchOrders (completionHandler completion: @escaping (Result<OrdersResponse,Error>) -> Void)
    
}
class OrdersServiceImp : OrdersService{
    static func fetchOrders (completionHandler completion: @escaping (Result<OrdersResponse,Error>) -> Void){
       let urlStr = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/7421196239083/orders.json"
        
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
                
                   print("fetchOrders error data")
                return
            }
            do {
                var json = JSONDecoder()
                json.keyDecodingStrategy = .convertFromSnakeCase
                
                let brands = try json.decode(OrdersResponse.self,from: data)
              
                completion(.success(data: brands))
               }catch let error as Error{
                   completion(.failure(error: error))
                   print("fetchBrands error catch : ",error )
            }
        }
        task.resume()
    }
}
