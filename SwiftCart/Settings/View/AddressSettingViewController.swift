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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAddresse(_ sender: Any) {
        
        guard let address1 = addresseText.text, !address1.isEmpty,
        let city = cityText.text, !city.isEmpty
        else {
                    print("All fields are required")
                    return

            
        }
        let addressData = AddressData(
                  address1: address1,
                  city: city,
                  customerId: customerId

                  
              )
              
              saveLocation(addressData: addressData)
          }
          
          func saveLocation(addressData: AddressData) {
              viewModel?.addLocation(customerId: addressData.customerId ?? 0 , addressData: addressData)
              delegate?.reload()
              dismiss(animated: true, completion: nil)
          }
      }
