//
//  DiscountViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 15/06/2024.
//

import Foundation
class DiscountViewModel{
    var couponsResult: [DiscountCodes] = [] {
          didSet {
              print("Coupons updated: \(couponsResult)")
          }
      }

      var failureHandler: ((String) -> Void)?

      func getCouponsFromModel() {
          DiscountService.getPriceRules { [weak self] response in
              switch response {
              case .success(let success):
                  print("price rule Id \(success.price_rules[0].id)")
                  var couponsList: [DiscountCodes] = []
                  let dispatchGroup = DispatchGroup()
                  for priceRule in success.price_rules {
                      dispatchGroup.enter()
                      DiscountService.getDiscountCodes(discountId: "\(priceRule.id!)") { result in
                          switch result {
                          case .success(let couponsResponse):
                              if let firstDiscountCode = couponsResponse.discount_codes.first {
                                  couponsList.append(firstDiscountCode)
                              }
                          case .failure(let err):
                              print("Error home \(err)")
                          }
                          dispatchGroup.leave()
                      }
                  }
                  dispatchGroup.notify(queue: .main) {
                      self?.couponsResult = couponsList
                  }
              case .failure(let failure):
                  print(failure)
                  self?.failureHandler?(failure.localizedDescription)
              }
          }
      }
  }

