//
//  ItemManager.swift
//  SwiftCart
//
//  Created by rwan elmtary on 15/06/2024.
//
import Foundation
import RxSwift
class ItemManager {
    var items: [LineItems]
    var lineItemsList = PublishSubject<[LineItems]>()

    init(items: [LineItems]) {
        self.items = items
    }

    func incrementQuantity(at index: Int) {
        guard index < items.count else { return }
        guard let currentQuantity = items[index].quantity,
              let maxQuantity = Int(items[index].properties?[1].value ?? "0"),
              currentQuantity < maxQuantity else { return }

        items[index].quantity = currentQuantity + 1
        lineItemsList.onNext(items)
    }

    func decrementQuantity(at index: Int) {
        guard index < items.count else { return }
        guard let currentQuantity = items[index].quantity, currentQuantity > 1 else { return }

        items[index].quantity = currentQuantity - 1
        lineItemsList.onNext(items)
    }

    func setQuantity(at index: Int, to newQuantity: Int) {
        guard index < items.count else { return }
        guard let maxQuantity = Int(items[index].properties?[1].value ?? "0"),
              newQuantity >= 1, newQuantity <= maxQuantity else { return }

        items[index].quantity = newQuantity
        lineItemsList.onNext(items)
    }
}
