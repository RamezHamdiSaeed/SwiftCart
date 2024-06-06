//  AddressesNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation


class AddressesNetwork {
    static func fetchLocationsFromShopify(customerId: Int, completion: @escaping ([Address]?) -> Void) {
        let url = URL(string: "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/7504624025851.json")
        
        guard let newUrl = url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: newUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching addresses: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(Customer.self, from: data)
                completion(response.addresses)
            } catch {
                print("Error parsing addresses: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    
    static func saveLocationToShopify(customerId: Int, addressData: AddressData, completion: @escaping (Result<Bool, Error>) -> Void) {
            let url = URL(string: "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/7504624025851/addresses.json")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let address: [String: Any] = [
                "customer_address": [
                    "address1": addressData.address1,
                    "address2": addressData.address2,
                    "city": addressData.city,
                    "country": addressData.country,
                    "country_code": addressData.countryCode,
                    "country_name": addressData.countryName,
                    "company": addressData.company,
                    "customer_id": ["id": addressData.customerId],
                 
                    "default": true
                ]
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: address, options: [])
                request.httpBody = jsonData
            } catch {
                print("Error creating JSON data: \(error)")
                completion(.failure(error: error))
                return
            }
            
            // Set the Content-Type header
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Perform the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error saving address: \(error)")
                    completion(.failure(error: error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if let data = data {
                        let responseString = String(data: data, encoding: .utf8)
                        print("Response Data: \(responseString ?? "No response data")")
                    }
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                        completion(.success(data: true))
                    } else {
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to save address"])
                        completion(.failure(error: error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response from server"])
                    completion(.failure(error: error))
                }
            }.resume()
        }
    }

