//
//  OrderServiceImp.swift
//  SwiftCart
//
//  Created by marwa on 07/06/2024.
//

import Foundation

//https://mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/7495574716667/orders.json

//https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com/admin/api/2024-04/orders.json?status=any

//protocol OrdersService{
//    static func fetchOrders (customerId :  String, completionHandler completion: @escaping (Result<OrdersResponse,Error>) -> Void)
//    
//}
//class OrdersServiceImp : OrdersService{
//    static func fetchOrders (customerId :  String, completionHandler completion: @escaping (Result<OrdersResponse,Error>) -> Void){
//       let urlStr = "https://mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/\(customerId)/orders.json"
//        
//        let url = URL(string: urlStr)
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error: error))
//                
//                   print("fetchOrders error error")
//                return
//            }
//            guard let data = data else {
//                completion(.failure(error: error!))
//                
//                   print("fetchOrderss error data")
//                return
//            }
//            do {
//                var json = JSONDecoder()
//                json.keyDecodingStrategy = .convertFromSnakeCase
//                
//                let brands = try json.decode(OrdersResponse.self,from: data)
//              
//                completion(.success(data: brands))
//                print("fetchOrderss  : ")
//               }catch let error as Error{
//                   completion(.failure(error: error))
//                   print("fetchOrderss error catch : ",error )
//            }
//        }
//        task.resume()
//    }
//}
