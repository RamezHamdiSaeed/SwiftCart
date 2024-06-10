//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Ramez Hamdi Saeed on 10/06/2024.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var productImage: String?
    @NSManaged public var productID: Int32

}
