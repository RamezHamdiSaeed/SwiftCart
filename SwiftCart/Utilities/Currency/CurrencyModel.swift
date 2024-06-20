//
//  CurrencyModel.swift
//  SwiftCart
//
//  Created by marwa on 13/06/2024.
//

import Foundation

struct CurrencyModel: Codable {
    let result: String
    let documentation: String
    let termsOfUse: String
    let timeLastUpdateUnix: Int
    let timeLastUpdateUTC: String
    let timeNextUpdateUnix: Int
    let timeNextUpdateUTC: String
    let baseCode: String
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case result
        case documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}

class CurrencyServiceImp {
    private init() {}

    static func fetchConversionRate(coinStr: String, completion: @escaping (Double?) -> Void) {
        let urlStr = "https://v6.exchangerate-api.com/v6/afd5df0075af54af2600201d/latest/USD"
        guard let url = URL(string: urlStr) else {
            completion(nil)
            print("Invalid URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
                print("fetchConversionRate error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(nil)
                print("fetchConversionRate error: No data")
                return
            }
            
            print("Received data: \(String(data: data, encoding: .utf8) ?? "N/A")")
            
            do {
                let jsonDecoder = JSONDecoder()
               // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try jsonDecoder.decode(CurrencyModel.self, from: data)
                print(decodedData)
                if let rate = decodedData.conversionRates[coinStr] {
                    print("rate, ",rate)
                    completion(rate)
                } else {
                    completion(nil)
                    print("fetchConversionRate error: Rate not found for \(coinStr)")
                }
            } catch {
                completion(nil)
                print("fetchConversionRate error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

class CurrencyImp {
    static func saveCurrencyToUserDefaults(coin: String) {
        UserDefaults.standard.set(coin, forKey: "coin")
    }

    static func getCurrencyFromUserDefaults() -> String {
        if let rateString = UserDefaults.standard.string(forKey: "coin") {
            return rateString
        }
        return "usd"
    }
}

enum Coins: String {
    case egp = "EGP"
    case usd = "USD"
    case eur = "EUR"
}

func getPrice( completion: @escaping (Double) -> Void) {

    let userCurrency = CurrencyImp.getCurrencyFromUserDefaults()
    let coin: Coins

    switch userCurrency {
    case "EGP":
        coin = .egp
    case "USD":
        coin = .usd
    case "EUR":
        coin = .eur
    default:
        completion(1.0)
        return
    }

CurrencyServiceImp.fetchConversionRate(coinStr: coin.rawValue) {
    rateRes in
       guard let rate = rateRes else {
           completion(0.0)
    return

}

        completion(rateRes!)
    }
   completion(0.0)
}

func convertPrice(price: String , rate : Double) -> Double{
    
     guard let priceD = Double(price) else {
         return 1.0
     }
    let convertedPrice = priceD * rate
    return convertedPrice
}
