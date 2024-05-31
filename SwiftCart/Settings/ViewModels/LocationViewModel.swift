//
//  LocationViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation

class LocationViewModel {
    var locations: [Adresses] = []
    var currencies: [Currency] = []
    
    var selectedCurrency: Currency? {
        didSet {
            DispatchQueue.main.async {
                self.onCurrencyChanged?(self.selectedCurrency)
            }
        }
    }
    
    var onCurrencyChanged: ((Currency?) -> Void)?
    var onExchangeRatesFetched: (() -> Void)?
    
    func fetchExchangeRate() {
        CurrencyNetwork.fetchExchangeRate { [weak self] currencies, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let currencies = currencies else {
                print("No currencies fetched")
                return
            }
            
            self.currencies = currencies
            DispatchQueue.main.async {
                self.onExchangeRatesFetched?()
            }
        }
    }
    
    func changeCurrency(to code: String) {
        if let currency = currencies.first(where: { $0.code == code }) {
            selectedCurrency = currency
        }
    }
    
    func getCurrencies() -> [Currency] {
        return currencies
    }
    
    func addLocation(name: String, coordinate: CLLocationCoordinate2D) {
        let newLocation = Adresses(name: name, coordinate: coordinate)
        locations.append(newLocation)
        saveLocations()
    }
    
    func saveLocations() {
        // Save to user defaults or post to Shopify
    }
    
    func loadLocations() {
        // Load from Shopify
    }
}
