//
//  HomeViewMdel.swift
//  SwiftCart
//
//  Created by marwa on 24/05/2024.
//

import Foundation
class HomeViewModel {
    var brandsClosure : ([SmartCollection])->Void = {_ in }
    var discountCodesClosure: (() -> Void) = {}
    var couponsResult: [DiscountCodes]?{
            didSet{
                discountCodesClosure()
                print("couponsResult did called \(couponsResult?.count)")
            }
        }

    
    func getBrands (){
        NetworkServicesImpl.fetchBrands { [weak self] res in
            switch res {
            case .success(let response) :
                self?.brandsClosure(response.smartCollections)
                print("HomeViewMdel success")
                
            case .failure(_):
                print("HomeViewMdel error")
        
            }
        }
    }
    func getDiscountCodes() {
          DiscountService.getPriceRules { [weak self] response in
              switch response {
              case .success(let success):
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
                              print("Error fetching discount codes: \(err)")
                          }
                          dispatchGroup.leave()
                      }
                  }
                  dispatchGroup.notify(queue: .main) {
                      self?.couponsResult = couponsList
                  }
              case .failure(let failure):
                  print(failure)
              }
          }
      }
  }

