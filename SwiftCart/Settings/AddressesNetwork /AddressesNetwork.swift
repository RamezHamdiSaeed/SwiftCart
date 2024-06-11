//  AddressesNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation


// AddressesNetwork.swift
import Foundation

class AddressesNetwork {
    static func fetchLocationsFromShopify(customerId: Int, completion: @escaping ([Address]?) -> Void) {
        let urlString = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/\(customerId)/addresses.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching addresses: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(AddressDataModel.self, from: data)
                completion(response.addresses)
            } catch {
                print("Error parsing addresses: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    static func saveLocationToShopify(customerId: Int, addressData: AddressData, completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlString = "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/\(customerId)/addresses.json"
        guard let url = URL(string: urlString) else {
            completion(.failure(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let address: [String: Any] = [
            "customer_address": [
                "address1": addressData.address1 ?? "",
                "address2": addressData.address2 ?? "",
                "city": addressData.city ?? "",
                "country": addressData.country ?? "",
                "country_code": addressData.countryCode ?? "",
                "country_name": addressData.countryName ?? "",
                "company": addressData.company ?? "",
                // Add other address fields here
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
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error saving address: \(error)")
                completion(.failure(error: error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
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
