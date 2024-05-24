//
//  BrandService.swift
//  SwiftCart
//
//  Created by marwa on 24/05/2024.
//

import Foundation
class BrandService{
    static func fetchBrands (completionHandler completion: @escaping (Result<SmartCollectionsResponse,Error>) -> Void){
       let urlStr = "https://mad-ism-and.myshopify.com/admin/api/2024-04/smart_collections.json?since_id=482865238&access_token=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"
        
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
                   print("fetchBrands error error")
                return
            }
            guard let data = data else {
                completion(.failure(error!))
                
                   print("fetchBrands error data")
                return
            }
            do {
                var json = JSONDecoder()
                json.keyDecodingStrategy = .convertFromSnakeCase
                
                let brands = try json.decode(SmartCollectionsResponse.self,from: data)
              
                completion(.success(brands))
                print(brands.smartCollections[0])
               }catch let error as Error{
                completion(.failure(error))
                   print("fetchBrands error catch : ",error )
            }
        }
        task.resume()
    }
}
