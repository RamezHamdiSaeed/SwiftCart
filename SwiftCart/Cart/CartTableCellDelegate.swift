//
//  CartTableViewDelegate.swift
//  SwiftCart
//
//  Created by rwan elmtary on 11/06/2024.
//

import Foundation
protocol CartTableCellDelegate:AnyObject{
    func didChangeQuantity(cell: CartTableViewCell, quantity: Int)

}
