//
//  NetworkingManager.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 01/06/2024.
//

import Foundation

class NetworkingManagerImpl : NetworkingManager{
    
    func networkingRequest<T: Codable>(path: String, queryItems: [URLQueryItem]?, method: NetworkingMethods, requestBody: Codable?, completeBaseURL:String?, networkResponse: @escaping (Result<T, NetworkError>) -> Void) {
        var baseURL = ""
        if  let completeBaseURL = completeBaseURL {
            baseURL = completeBaseURL
        } else{
            baseURL = "https://\(NetworkingKeys.accessTocken.rawValue):\(NetworkingKeys.adminKey.rawValue)@\(NetworkingKeys.shop.rawValue).myshopify.com//admin/api/2024-04"
        }
        print(baseURL+path)
        var urlComponents = URLComponents(string: baseURL + path)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            networkResponse(.failure(error: .inValidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if method == .POST {
            request.addValue(NetworkingKeys.adminKey.rawValue, forHTTPHeaderField: "X-Shopify-Access-Token")
        }
        if let requestBody = requestBody {
            do {
                
                request.httpBody = try JSONEncoder().encode(requestBody)
                let jsonString = String(data: request.httpBody!, encoding: .utf8)
                print("Raw Body Data: \(jsonString ?? "Unable to convert data to string")")
            } catch {
                networkResponse(.failure(error: .invalidData))
                print("Error encoding request body: \(error.localizedDescription)")
            }
        }

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                networkResponse(.failure(error: .inValidResponse))
                print("Error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == (method == .POST ? 201 : 200) {
                    
                    if let data = data {
                        do {
                            let jsonString = String(data: data, encoding: .utf8)
                            print("Raw Response Data: \(jsonString ?? "Unable to convert data to string")")
                            let responseData = try JSONDecoder().decode(T.self, from: data)
                            networkResponse(.success(data: responseData))
                            print("Response Data: \(responseData)")
                        } catch {
                            networkResponse(.failure(error: .inValidResponse))
                            print("Error parsing JSON: \(error.localizedDescription)")
                        }
                    }
                }
            }
            

        }

        task.resume()
    }
}

enum Result<T, E: Error> {
    case success(data: T)
    case failure(error: E)
}


enum NetworkingKeys : String{
    case accessTocken = "6f14721eafce0d8aee32fc7b400c138c"
    case adminKey = "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"
    case shop = "mad-ios-ism-2"
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
