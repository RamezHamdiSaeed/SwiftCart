//
//  NetworkingManager.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 01/06/2024.
//

import Foundation

class NetworkingManager{
    
    static func networkingRequest<T:Codable>(path:String,queryItems:[URLQueryItem]?,method:NetworkingMethods,requestBody:Codable?,responseData:T?, networkResponse:@escaping (Result)->Void) ->Void{
        let baseURL = "https://\(NetworkingKeys.accessTocken.rawValue):\(NetworkingKeys.adminKey.rawValue)@\(NetworkingKeys.shop.rawValue).myshopify.com//admin/api/2024-04"
        
        var urlComponents = URLComponents(string: baseURL + path)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            networkResponse(.failure(error: NetworkError.inValidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let requestBody = requestBody {
            do {
                request.httpBody = try JSONEncoder().encode(requestBody)
            } catch {
                
                networkResponse(.failure(error: NetworkError.invalidData))
                print("Error encoding request body: \(error.localizedDescription)")
            }

        }

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                
                networkResponse(.failure(error: NetworkError.inValidResponse))
                print("Error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
            }

            if let data = data {
                
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    networkResponse(.success(data: responseData))
                    print("Response Data: \(responseData)")
                } catch {
                    networkResponse(.failure(error: NetworkError.inValidResponse))
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }
    
}

enum NetworkingKeys : String{
    case accessTocken = "6f14721eafce0d8aee32fc7b400c138c"
    case adminKey = "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"
    case shop = "mad-ios-ism-2"
}

enum Result {
    case success(data: Any)
    case failure(error: Error)
}

enum NetworkError : Error{
    case inValidUrl
    case inValidResponse
    case invalidData
}

enum NetworkingMethods : String{
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
