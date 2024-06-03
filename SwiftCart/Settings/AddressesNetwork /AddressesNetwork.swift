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
    
    
    
    static func saveLocationToShopify(customerId: Int, name: String, completion: @escaping (Bool) -> Void) {
           let url = URL(string:  "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers/7504624025851.json")!
          
           var request = URLRequest(url: url)
           request.httpMethod = "PUT"
           
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
                   "default": true
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
}
