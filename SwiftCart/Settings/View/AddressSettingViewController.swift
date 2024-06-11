//
//  AddressSettingViewController.swift
//  SwiftCart
//
//  Created by rwan elmtary on 03/06/2024.
//

// AddressSettingViewController.swift

import UIKit

class AddressSettingViewController: UIViewController {
    var viewModel: LocationViewModel?
    var customerId: Int?
    var email: String?
    var coordinates: String?
    var city: String?
    var delegate: ReloadProtocol?

    @IBOutlet weak var addresseText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var zipText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAddresse(_ sender: Any) {
        guard let address1 = addresseText.text, !address1.isEmpty,
                    let city = cityText.text, !city.isEmpty,
                    let country = countryText.text, !country.isEmpty,
                    let phone = phoneText.text, !phone.isEmpty,
                    let zip = zipText.text, !zip.isEmpty else {
                  print("All fields are required")
                  return
            
        }
        let addressData = AddressData(
    address1: address1,
    address2: nil,
    city: city,
    company: nil,
    firstName: nil,
    lastName: nil,
    phone: phone,
    province: nil,
    country: country,
    zip: zip,
    name: nil,
    provinceCode: nil,
    countryCode: nil,
    countryName: nil
)

saveLocation(addressData: addressData)
}

func saveLocation(addressData: AddressData) {
guard let customerId = customerId else { return }
viewModel?.addLocation(customerId: customerId, addressData: addressData)
delegate?.reload()
dismiss(animated: true, completion: nil)
}
      }
