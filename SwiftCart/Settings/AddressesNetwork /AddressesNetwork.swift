//
//  AddressesNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation


class AddressesNetwork {
    func saveLocationToShopify(customerId: Int, email: String, name: String, coordinates: CLLocationCoordinate2D, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com/admin/api/2024-04/customers/\(customerId)/addresses.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let address = [
            "customer_address": [
                "customer_id": customerId,
                "zip": "90210",
                "country": "United States",
                "province": "Kentucky",
                "city": "Louisville",
                "address1": name,
                "address2": "",
                "first_name": nil,
                "last_name": nil,
                "company": nil,
                "phone": "555-625-1199",
                "id": customerId, // This should be the customer ID
                "name": "",
                "province_code": "KY",
                "country_code": "US",
                "country_name": "United States",
                "default": true
            ]
        ]
        
        
        let jsonData = try! JSONSerialization.data(withJSONObject: address, options: [])
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error saving address: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response Data: \(responseString ?? "No response data")")
                }
            }
            
            print("Address saved successfully")
            completion(true)
        }.resume()
    }
    
    
    
    func fetchLocationsFromShopify(customerId: Int, completion: @escaping ([Adresses]?) -> Void) {
        let url = URL(string: "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com/admin/api/2024-04/customers/\(customerId)/addresses.json")!
        var request = URLRequest(url: url)
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
            
            // Print or log the raw response data
            let responseString = String(data: data, encoding: .utf8)
            print("Response Data: \(responseString ?? "No response data")")
            
            
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let addressesArray = json["addresses"] as? [[String: Any]] {
            
                

                    var addresses: [Adresses] = []
                    
                    for addressDict in addressesArray {
                        if let name = addressDict["address1"] as? String,
                           let latitude = addressDict["latitude"] as? CLLocationDegrees,
                           let longitude = addressDict["longitude"] as? CLLocationDegrees {
                            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            let address = Adresses(name: name, coordinate: coordinate)
                            addresses.append(address)
                        }
                    }
                    completion(addresses)
                } else {
                    // Handle unexpected response data format
                    print("Unexpected response data format")
                    completion(nil)
                }
            } catch {
                // Handle parsing error
                print("Error parsing addresses: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
