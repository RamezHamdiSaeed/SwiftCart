//
//  CurrencyNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation

class CurrencyNetwork {
    
    static func fetchExchangeRate(completionHandler: @escaping ([Currency]?, Error?) -> Void) {
        let urlString = "https://www.floatrates.com/daily/usd.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completionHandler(nil, nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode([String: Currency].self, from: data)
                let currencies = Array(result.values)
                completionHandler(currencies, nil)
            } catch let jsonError {
                completionHandler(nil, jsonError)
            }
        }
        
        task.resume()
    }
}
