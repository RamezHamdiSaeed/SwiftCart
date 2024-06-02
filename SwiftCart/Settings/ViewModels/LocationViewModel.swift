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
            onCurrencyChanged?(selectedCurrency)
        }
    }
    
    var onCurrencyChanged: ((Currency?) -> Void)?
    var onExchangeRatesFetched: (() -> Void)?
    var onLocationsFetched: (() -> Void)?

    // MARK: - Public Methods
    
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
        selectedCurrency = currencies.first { $0.code == code }
    }
    
    func getCurrencies() -> [Currency] {
        return currencies
    }
    
    func addLocation(customerId: Int, email: String, name: String, coordinate: CLLocationCoordinate2D) {
        let newLocation = Adresses(id: customerId, name: name, coordinate: coordinate)
        locations.append(newLocation)
        addressesNetwork.saveLocationToShopify(customerId: customerId, name: name) { success in
            if success {
                self.onLocationsFetched?()
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
