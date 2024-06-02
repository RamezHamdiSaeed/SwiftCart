//  AddressesNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation


class AddressesNetwork {
    func saveLocationToShopify(customerId: Int, name: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/customers/\(customerId)/addresses.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let address = [
            "customer_address": [
                "customer_id": customerId,
                "first_name": "Samuel",
                "last_name": "de Champlain",
                "company": "Fancy Co.",
                "address1": "1 Rue des Carrieres",
                "address2": "Suite 1234",
                "city": "Montreal",
                "province": "Quebec",
                "country": "Canada",
                "zip": "G1R 4P5",
                "phone": "819-555-5555",
                "name": "Samuel de Champlain",
                "province_code": "QC",
                "country_code": "CA",
                "country_name": "Canada",
                "default": false
            ]
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: address, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            completion(false)
            return
        }
        
        // Set the Content-Type header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error saving address: \(error)")
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
        let url = URL(string: "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/customers/\(customerId)/addresses.json")!
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
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let customerAddresses = json["customer_addresses"] as? [[String: Any]] {
                    
                    var addresses: [Adresses] = []
                    for addressDict in customerAddresses {
                        if let id = addressDict["id"] as? Int,
                           let name = addressDict["address1"] as? String,
                           let latitude = addressDict["latitude"] as? CLLocationDegrees,
                           let longitude = addressDict["longitude"] as? CLLocationDegrees {
                            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            let address = Adresses(id: id, name: name, coordinate: coordinate)
                            addresses.append(address)
                        }
                    }
                    completion(addresses)
                } else {
                    print("Unexpected response data format")
                    completion(nil)
                }
            } catch {
                print("Error parsing addresses: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
