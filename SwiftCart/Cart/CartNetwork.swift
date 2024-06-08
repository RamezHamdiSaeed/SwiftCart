//
//  CartNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 07/06/2024.
//

import Foundation
class CartNetwork{
    static let shared : CartNetwork = CartNetwork()
     
    func createOrder (customerID: Int , lineItem: LineItem ,completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string:"https://6f14721eafce0d8aee32fc7b400c138c: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@mad-ios-ism-2.myshopify.com//admin/api/2024-04/draft_orders.json")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let draftOrder = DraftOrder(
                   lineItems: [lineItem],
                   customer: Customr(id: customerID),
                   useCustomerDefaultAddress: true
               )
        let draftOrderResponse = DraftOrderResponse(draftOrder: draftOrder)
               
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: draftOrder, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            completion(.failure(error))
            return
        }
        
        // Set the Content-Type header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error saving address: \(error)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response Data: \(responseString ?? "No response data")")
                }
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    completion(.success(true))
                } else {
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to save address"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response from server"])
                completion(.failure(error))
            }
        }.resume()
    }
}
