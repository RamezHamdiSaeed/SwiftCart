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
    var addressesNetwork = AddressesNetwork()
    
    var selectedCurrency: Currency? {
        didSet {
            DispatchQueue.main.async {
                self.onCurrencyChanged?(self.selectedCurrency)
            }
        }
    }
    
    var onCurrencyChanged: ((Currency?) -> Void)?
    var onExchangeRatesFetched: (() -> Void)?
    var onLocationsFetched: (() -> Void)?

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
    
    func addLocation(customerId: Int, email: String, name: String, coordinate: CLLocationCoordinate2D) {
        let newLocation = Adresses(name: name, coordinate: coordinate)
        locations.append(newLocation)
        addressesNetwork.saveLocationToShopify(customerId: customerId, email: email, name: name, coordinates: coordinate) { success in
            if success {
                DispatchQueue.main.async {
                    self.onLocationsFetched?()
                }
            }
        }
    }
    
    func loadLocations(customerId: Int) {
        addressesNetwork.fetchLocationsFromShopify(customerId: customerId) { [weak self] fetchedLocations in
            guard let self = self else { return }
            if let fetchedLocations = fetchedLocations {
                self.locations = fetchedLocations
                DispatchQueue.main.async {
                    self.onLocationsFetched?()
                }
            }
        }
    }
}
