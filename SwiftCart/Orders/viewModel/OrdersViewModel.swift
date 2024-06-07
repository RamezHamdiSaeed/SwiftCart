//
//  OrdersViewModel.swift
//  SwiftCart
//
//  Created by marwa on 08/06/2024.
//

import Foundation
class OrdersViewModel {
    var ordersClosure : ([Order])->Void = {_ in }
    
    func getOrders (){
        OrdersServiceImp.fetchOrders { [weak self] res in
            switch res {
            case .success(let response) :
                self?.ordersClosure(response.orders!)
                print("HomeViewMdel success")
                
            case .failure(_):
                print("HomeViewMdel error")
        
            }
        }
    }
}
