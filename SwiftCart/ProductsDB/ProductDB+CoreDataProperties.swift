//
//  ProductDB+CoreDataProperties.swift
//  
//
//  Created by Ramez Hamdi Saeed on 10/06/2024.
//
//

import Foundation
import CoreData


extension ProductDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductDB> {
        return NSFetchRequest<ProductDB>(entityName: "ProductDB")
    }

    @NSManaged public var productID: Int64
    @NSManaged public var productImage: String?
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Double

}
