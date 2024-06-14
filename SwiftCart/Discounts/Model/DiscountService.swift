//
//  DiscountService.swift
//  SwiftCart
//
//  Created by rwan elmtary on 15/06/2024.
//

import Foundation
class DiscountService{
    static func getDiscountCodes(discountId: String, completionHandler: @escaping (Result<DiscountCodesResponse, Error>) -> Void) {
        let accessToken = "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"

         let urlString = "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/price_rules/\(discountId)/discount_codes.json"
         guard let url = URL(string: urlString) else {
             completionHandler(.failure(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
             return
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
         
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
             if let error = error {
                 completionHandler(.failure(error: error))
                 return
             }
             
             guard let data = data else {
                 completionHandler(.failure(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                 return
             }
             
             do {
                 let discountResponse = try JSONDecoder().decode(DiscountCodesResponse.self, from: data)
                 completionHandler(.success(data: discountResponse))
             } catch {
                 completionHandler(.failure(error: error))
             }
         }
         
         task.resume()
     }
 
static func getPriceRules(completionHandler: @escaping (Result<DiscountModel, Error>) -> Void) {
    let accessToken = "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"

       let urlString = "https://mad-ios-ism-2.myshopify.com/admin/api/2024-04/price_rules.json"
       guard let url = URL(string: urlString) else {
           completionHandler(.failure(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
           return
       }
       
       var request = URLRequest(url: url)
       request.httpMethod = "GET"
       request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
       
       let task = URLSession.shared.dataTask(with: request) { data, response, error in
           if let error = error {
               completionHandler(.failure(error: error))
               return
           }
           
           guard let data = data else {
               completionHandler(.failure(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
               return
           }
           
           do {
               let priceRulesResponse = try JSONDecoder().decode(DiscountModel.self, from: data)
               completionHandler(.success(data: priceRulesResponse))
           } catch {
               completionHandler(.failure(error: error))
           }
       }
       
       task.resume()
   }

}
