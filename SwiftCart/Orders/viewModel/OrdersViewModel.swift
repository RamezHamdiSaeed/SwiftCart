//
//  OrdersViewModel.swift
//  SwiftCart
//
//  Created by marwa on 08/06/2024.
//

import Foundation
class OrdersViewModel {
    var ordersClosure : ([Order])->Void = {_ in }
    var productsClosure : ([Product])->Void = {_ in }
    var rateClosure : (Double)->Void = {_ in }
    
    private var networkService: NetworkServices
    init(networkService: NetworkServices = NetworkServicesImpl()) {
          self.networkService = networkService
      }
    func getRate(){
        getPrice() { [weak self] rate in
            self?.rateClosure(rate)
        }
    }
    //rwanId = 7520873382139
    var customerId :  String = "\(User.id ?? 7495574716667)"

    
    func getOrders (){
    //    if User.id == nil{}else{
            networkService.fetchOrders(customerId: customerId) { [weak self] res in
                switch res {
                case .success(let response) :
                    self?.ordersClosure(response.orders!)
                    print("fetchOrderss viewmodel success")
                    
                case .failure(_):
                    print("fetchOrderss viewmodel error")
                    
                }
            }
            
      //  }
        
    }
}
