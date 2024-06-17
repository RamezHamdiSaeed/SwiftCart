//
//  FavoriteSync.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 17/06/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class FavoriteSync{
    
    static func uploadProducts(for userEmail: String, products: [ProductTemp]) {
        let db = Firestore.firestore()
        products.forEach{
            currentProduct in
            let productData = currentProduct.toDictionary()
            
            db.collection("favlists")
                .document(userEmail)
                .collection("products")
                .document(String(describing: currentProduct.id))
                .setData(productData) { error in
                    if let error = error {
                        print("Error uploading product: \(error.localizedDescription)")
                    } else {
                        print("Product successfully uploaded!")
                    }
                }
        }
       
    }
    
    static func fetchProducts(for userEmail: String, completion: @escaping ([ProductTemp]) -> Void) {
        let db = Firestore.firestore()
        db.collection("favlists")
            .document(userEmail)
            .collection("products")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching products: \(error.localizedDescription)")
                    completion([])
                    return
                }

                var products: [ProductTemp] = []
                if let documents = snapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        let id = data["id"] as? Int ?? Int(document.documentID)
                        let image = data["image"] as? String ?? ""
                        let price = data["price"] as? Double ?? 0.0
                        let name = data["name"] as? String ?? ""
                        let product = ProductTemp(id: id!, name: name, price: price, isFavorite: true, image: image)
                        products.append(product)
                    }
                }
                completion(products)
            }
    }
    
}
