//
//  FavoriteSync.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 17/06/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class CustomerInfoSync {
    
    static func uploadCustomerPhoneNumber(for userEmail: String, phoneNumber: String, whenSuccess: (() -> Void)? = nil) {
        let db = Firestore.firestore()
        
        db.collection("phones")
            .document(userEmail)
            .setData(["phone": phoneNumber]) { error in
                if let error = error {
                    print("Error uploading product: \(error.localizedDescription)")
                } else {
                    print("Product successfully uploaded!")
                    print("product attached to \(userEmail)")
                    whenSuccess?()
                }
            }
    }
    
    static func fetchPhoneNumber(for userEmail: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        db.collection("phones")
            .document(userEmail)
            .getDocument { document, error in
                if let error = error {
                    print("Error fetching phone number: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                if let document = document, document.exists {
                    let data = document.data()
                    let phoneNumber = data?["phone"] as? String
                    completion(phoneNumber)
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
    }
}
