//
//  CurrencyNetwork.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

 import Foundation

func fetchExchangeRate() {
  //  let apiKey = "05edfcad48644b39069c100b13025854"
    let urlString = "https://www.floatrates.com/daily/usd.json"
    
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error.localizedDescription)")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let rates = json["conversion_rates"] as? [String: Double],
               let egpRate = rates["EGP"] {
                print("1 USD is equal to \(egpRate) EGP")
            } else {
                print("Error parsing JSON")
            }
        } catch let jsonError {
            print("JSON error: \(jsonError.localizedDescription)")
        }
    }
    
    task.resume()
}

