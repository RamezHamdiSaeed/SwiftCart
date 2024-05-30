//
//  AddressesNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation
 
class AddressesNetwork{
    
    func saveLocationToShopify(name : String , coordinates : CLLocationCoordinate2D){
        let url = URL(string: "https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/customers.json")!
        var request = URLRequest (url: url)
        request.httpMethod = "POST"
        
        let address = ["address": [
                "address1": name,
             
            ]]
        let jsonData = try! JSONSerialization.data(withJSONObject: address, options: [])
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
            }.resume()
        }



        
    }

