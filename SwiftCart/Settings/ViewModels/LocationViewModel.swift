//
//  LocationViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import Foundation
import CoreLocation

class LocationViewModel{
    var locations : [Adresses] = []
    
    func addLocation(name : String , coordinate : CLLocationCoordinate2D )
    {
        var newLocation = Adresses(name: name, coordinate: coordinate)
        locations.append(newLocation)
        saveLocations()
    }
    func saveLocations() {
        //coredata or post on shopify
       }
       
       func loadLocations() {
          // from shopify
       }
}
