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
    var locations: [Address]?{
        didSet{
            onLocationsFetched?()
        }
    }
    
    var onCurrencyChanged: ((Currency?) -> Void)?
    var onExchangeRatesFetched: (() -> Void)?
    var onLocationsFetched: (() -> Void)?
    
    
       func addLocation(customerId: Int, email: String, name: String, coordinate: String) {
            let newLocation = Address( city: name, address2: coordinate)
           locations?.append(newLocation)
            AddressesNetwork.saveLocationToShopify(customerId: customerId, name: name) { success in
                if success {
                    DispatchQueue.main.async {
                        self.onLocationsFetched?()
                    }
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
