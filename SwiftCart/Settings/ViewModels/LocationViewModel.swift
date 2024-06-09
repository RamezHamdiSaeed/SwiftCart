//  LocationViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation

class LocationViewModel {
    var currencies: [Currency]? = []
    var selectedCurrency: Currency? {
        didSet {
            DispatchQueue.main.async {
                self.onCurrencyChanged?(self.selectedCurrency)
            }
        }
    }
    var locations: [Address]? {
        didSet {
            onLocationsFetched?()
        }
    }
    var onCurrencyChanged: ((Currency?) -> Void)?
    var onExchangeRatesFetched: (() -> Void)?
    var onLocationsFetched: (() -> Void)?
    
    func addLocation(customerId: Int, addressData: AddressData) {
        AddressesNetwork.saveLocationToShopify(customerId: customerId, addressData: addressData) { result in
            switch result {
            case .success(let data):
                print("Added address successfully: \(data)")
                self.loadLocations(customerId: customerId) // Reload locations after adding a new one
            case .failure(let error):
                print("Failed to add address: \(error)")
            }
        }
    }

    func loadLocations(customerId: Int) {
        AddressesNetwork.fetchLocationsFromShopify(customerId: customerId) { [weak self] fetchedLocations in
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
