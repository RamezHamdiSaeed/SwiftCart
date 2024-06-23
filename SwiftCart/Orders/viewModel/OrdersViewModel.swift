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
    var imageUrlClosure : (String?)->Void = {_ in }
    private let detailsnetworkService = DetailsNetworkService(networkingManager: NetworkingManagerImpl())

    
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
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
                        self?.ordersClosure(response.orders!)
                        print("fetchOrderss viewmodel success")
                        
                    }
                
                case .failure(_):
                    print("fetchOrderss viewmodel error")
                    
                }
            }
            
      //  }
        
    }
    
    func getProductDetails(productID:String,whenSuccess:((String?)->())? = nil){
        ProductDetailsNetworkMgr.fetchProductsDetailsImage(singleCollectionId: productID){[weak self] res in
            switch res {
            case .success(let response) :
                self?.imageUrlClosure(response.product?.image?.src)
                whenSuccess?(response.product?.image?.src)
                print("getProductDetails success")
                
            case .failure(let error):
                print("getProductDetails error :",error.localizedDescription)
            }
        }
    }
    
}
