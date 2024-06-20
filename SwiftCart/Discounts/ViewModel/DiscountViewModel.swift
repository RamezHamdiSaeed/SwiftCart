//
//  DiscountViewModel.swift
//  SwiftCart
//
//  Created by rwan elmtary on 15/06/2024.
//

import Foundation

class DiscountViewModel {
    var couponsResult: [DiscountCodes] = [] {
        didSet {
            print("Coupons updated: \(couponsResult)")
        }
    }

    var priceRules: [PriceRule] = []

    var failureHandler: ((String) -> Void)?

    func getCouponsFromModel(completion: @escaping ([DiscountCodes]) -> Void) {
        DiscountService.getPriceRules { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let success):
                self.priceRules = success.price_rules
                var couponsList: [DiscountCodes] = []
                let dispatchGroup = DispatchGroup()

                for priceRule in success.price_rules {
                    dispatchGroup.enter()
                    DiscountService.getDiscountCodes(discountId: "\(priceRule.id!)") { result in
                        defer { dispatchGroup.leave() }

                        switch result {
                        case .success(let couponsResponse):
                            couponsList.append(contentsOf: couponsResponse.discount_codes)
                        case .failure(let err):
                            print("Error fetching discount codes: \(err)")
                        }
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    self.couponsResult = couponsList
                    completion(couponsList) // Pass fetched coupons to completion handler
                }

            case .failure(let failure):
                print("Error fetching price rules: \(failure.localizedDescription)")
                self.failureHandler?(failure.localizedDescription)
            }
        }
    }

    func getPriceRule(for coupon: DiscountCodes) -> PriceRule? {
        return priceRules.first { $0.id == coupon.price_rule_id }
    }



    func validateDiscount(discountCode: String, completionHandler: @escaping (Result<DiscountCodes, Error>) -> Void) {
        DiscountService.checkForCoupons(discountCode: discountCode) { result in
            switch result {
            case .success(let discount):
                completionHandler(.success(data: discount))
            case .failure(let error):
                completionHandler(.failure(error: error))
            }
        }
    }
}
