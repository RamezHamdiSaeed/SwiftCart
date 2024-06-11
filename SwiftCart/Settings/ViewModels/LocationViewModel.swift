//  LocationViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation


class LocationViewModel {
    var locations: [Address]? {
        didSet {
            onLocationsFetched(locations ?? [])
        }
    }
    var onLocationsFetched: (([Address]) -> ()) = { _ in}
    
    func addLocation(customerId: Int, addressData: AddressData) {
        AddressesNetwork.saveLocationToShopify(customerId: customerId, addressData: addressData) { result in
            switch result {
            case .success:
                self.loadLocations(customerId: customerId)
            case .failure(let error):
                print("Failed to add address: \(error)")
            }
        }
    }

    func loadLocations(customerId: Int) {
        AddressesNetwork.fetchLocationsFromShopify(customerId: customerId) { [weak self] fetchedLocations in
            guard let self = self else { return }
            self.locations = fetchedLocations
        }
    }
}
