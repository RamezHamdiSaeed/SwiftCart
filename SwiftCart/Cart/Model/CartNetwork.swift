//
//  CartNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 07/06/2024.
//

import Foundation

class CartNetwork {
    static let shared: CartNetwork = CartNetwork()
    
    func createOrder(customerID: Int, lineItem: LineItemRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
          let accessToken = "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"
          
          let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/draft_orders.json")!
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          
          let draftOrderRequestBody = DraftOrderRequestBody(lineItems: [lineItem], customer: CustomerID(id: customerID), useCustomerDefaultAddress: true)
          let draftOrderRequest = DraftOrderRequest(draftOrder: draftOrderRequestBody)
          
          let encoder = JSONEncoder()
          encoder.keyEncodingStrategy = .convertToSnakeCase
          
          do {
              let jsonData = try encoder.encode(draftOrderRequest)
              request.httpBody = jsonData
              print("Request JSON: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
          } catch {
              print("Error creating JSON data: \(error)")
              completion(.failure(error: error))
              return
          }
          
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          request.addValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
          
          URLSession.shared.dataTask(with: request) { data, response, error in
              if let error = error {
                  print("Error saving order: \(error)")
                  completion(.failure(error: error))
                  return
              }
              
              if let httpResponse = response as? HTTPURLResponse {
                  print("HTTP Status Code: \(httpResponse.statusCode)")
                  if let data = data {
                      let responseString = String(data: data, encoding: .utf8)
                      print("Response Data: \(responseString ?? "No response data")")
                      
                      do {
                          let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                          print("JSON Response: \(jsonResponse)")
                      } catch {
                          print("Error parsing JSON response: \(error)")
                      }
                      
                      if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                          completion(.success(data: true))
                      } else {
                          let errorMessage = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
                          let errorDescription = errorMessage?["errors"] as? String ?? "Unknown error"
                          let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])
                          completion(.failure(error: error))
                      }
                  }
              }
          }.resume()
      }
    func fetchDraftOrders(completion: @escaping (Result<[DraftOrder], Error>) -> Void) {
        let accessToken = "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"
        let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/draft_orders.json")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching draft orders: \(error)")
                completion(.failure(error: error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(error: NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let draftOrdersResponse = try JSONDecoder().decode(DraftOrdersResponse.self, from: data)
                if let draftOrders = draftOrdersResponse.draftOrders {
                    completion(.success(data: draftOrders))
                } else {
                    completion(.failure(error: NSError(domain: "No draft orders", code: -1, userInfo: nil)))
                }
            } catch {
                print("Error decoding draft orders: \(error)")
                completion(.failure(error: error))
            }
        }.resume()
    }
    func updateOrder(customerID: Int, draftOrderID: Int, lineItem: LineItemRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        let accessToken = "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"
        let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/draft_orders/\(draftOrderID).json")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
        
        let draftOrderRequestBody = DraftOrderRequestBody(lineItems: [lineItem], customer: CustomerID(id: customerID), useCustomerDefaultAddress: true)
        let draftOrderRequest = DraftOrderRequest(draftOrder: draftOrderRequestBody)
        
        do {
            let jsonData = try JSONEncoder().encode(draftOrderRequest)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error: error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(error: NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                completion(.success(data: true))
            } else {
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let errorMessage = jsonResponse?["errors"] as? String ?? "Unknown error"
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        completion(.failure(error: error))
                    } catch {
                        completion(.failure(error: error))
                    }
                } else {
                    completion(.failure(error: NSError(domain: "No data", code: httpResponse.statusCode, userInfo: nil)))
                }
            }
        }
        task.resume()
    }

    func deleteOrder(draftOrderID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
           let accessToken = "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"
           
           let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/draft_orders/\(draftOrderID).json")!
           
           var request = URLRequest(url: url)
           request.httpMethod = "DELETE"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error deleting order: \(error)")
                   completion(.failure(error: error))
                   return
               }
               
               if let httpResponse = response as? HTTPURLResponse {
                   print("HTTP Status Code: \(httpResponse.statusCode)")
                   if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                       completion(.success(data: true))
                   } else {
                       let errorMessage = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String: Any]
                       let errorDescription = errorMessage?["errors"] as? String ?? "Unknown error"
                       let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])
                       completion(.failure(error: error))
                   }
               }
           }.resume()
       }
   
    
    func completeDraftOrder(draftOrderID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let accessToken = "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"
        let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/draft_orders/\(draftOrderID)/complete.json")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(error: NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                completion(.success(data: true))
            } else {
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let errorMessage = jsonResponse?["errors"] as? String ?? "Unknown error"
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        completion(.failure(error: error))
                    } catch {
                        completion(.failure(error: error))
                    }
                } else {
                    completion(.failure(error: NSError(domain: "No data", code: httpResponse.statusCode, userInfo: nil)))
                }
            }
        }.resume()
    }
    
    func deleteDraftOrder(draftOrderID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let accessToken = "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"
        let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/draft_orders/\(draftOrderID).json")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(error: NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                completion(.success(data: true))
            } else {
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let errorMessage = jsonResponse?["errors"] as? String ?? "Unknown error"
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        completion(.failure(error: error))
                    } catch {
                        completion(.failure(error: error))
                    }
                } else {
                    completion(.failure(error: NSError(domain: "No data", code: httpResponse.statusCode, userInfo: nil)))
                }
            }
        }.resume()
    }
}
