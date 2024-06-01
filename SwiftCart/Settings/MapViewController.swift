//
//  MapViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 30/05/2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var viewModel: LocationViewModel?
    @IBOutlet weak var map: MKMapView!
    var customerId: Int!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMap()
    }

    func setMap() {
        title = "Pick a Location"
        map.delegate = self
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.leftAnchor.constraint(equalTo: view.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        map.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: map)
            let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
            addAnnotationAtCoordinate(coordinate)
        }
    }

    private func addAnnotationAtCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let alert = UIAlertController(title: "New Location", message: "Enter a name for this location", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Location name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let locationName = alert.textFields?.first?.text, !locationName.isEmpty {
                self.saveLocation(name: locationName, coordinate: coordinate)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    func saveLocation(name: String, coordinate: CLLocationCoordinate2D) {
        viewModel?.addLocation(customerId: customerId, email: email, name: name, coordinate: coordinate)
        dismiss(animated: true, completion: nil)
    }
}
