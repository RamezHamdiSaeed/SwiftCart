//
//  OrdersViewModel.swift
//  SwiftCart
//
//  Created by marwa on 08/06/2024.
//

import Foundation
class OrdersViewModel {
    var ordersClosure : ([Order])->Void = {_ in }
    //rwanId = 7520873382139
    var customerId :  String = "7520873382139"
    //defaultId "7495574716667"
    
    func getOrders (){
        OrdersServiceImp.fetchOrders(customerId: customerId) { [weak self] res in
            switch res {
            case .success(let response) :
                self?.ordersClosure(response.orders!)
                print("fetchOrderss viewmodel success")
                
            case .failure(_):
                print("fetchOrderss viewmodel error")
        
            }
        }
    }
}
