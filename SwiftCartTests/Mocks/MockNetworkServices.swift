//
//  MockNetworkServices.swift
//  SwiftCartTests
//
//  Created by marwa on 16/06/2024.
//
//

import Foundation
@testable import SwiftCart
//class MockNetworkServices {
//    var shouldReturnError : Bool
//    init(shouldReturnError: Bool) {
//        self.shouldReturnError = shouldReturnError
//    }
//    var fakeBrandObj: [String: [SmartCollection]] = ["smart_collections": [
//        SmartCollection(
//            id: 422258540795,
//            handle: "adidas",
//            title: "ADIDAS",
//            updatedAt: "2024-06-15T15:20:43-04:00",
//            bodyHtml: "Adidas collection",
//            publishedAt: "2024-05-26T02:48:46-04:00",
//            sortOrder: "best-selling",
//            templateSuffix: "",
//            disjunctive: false,
//            rules: [
//                Rule(column: "title", relation: "contains", condition: "ADIDAS")
//            ],
//            publishedScope: "web",
//            adminGraphqlApiId: "gid://shopify/Collection/422258540795",
//            image: Image(
//                createdAt: "2024-05-26T02:48:46-04:00", alt: "",
//                width: 1000,
//                height: 676,
//                src: "https://cdn.shopify.com/s/files/1/0702/9630/5915/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1716706126"
//            )
//        )
//    ]]
//
//    enum responseWithError : Error{
//        case responseError
//    }
//}
//extension MockNetworkServices{
//     func fetchBrands (completionHandler completion: @escaping (Result<SmartCollectionsResponse,Error>) -> Void){
//         var brands : SmartCollectionsResponse!
//         do{
//             let brandData = try JSONSerialization.data(withJSONObject: fakeBrandObj)
//             brands = try JSONDecoder().decode(SmartCollectionsResponse.self, from: brandData)
//         }catch let error{
//             print(error.localizedDescription)
//         }
//
//         if shouldReturnError {
//             completion(.failure(error: responseWithError.responseError))
//         }else {
//             completion(.success(data: brands))
//         }
//    }
//}


class MockNetworkServices {
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let fakeBrandObj: [String: Any] = [
        "smartCollections": [
            [
                "id": 422258540795,
                "handle": "adidas",
                "title": "ADIDAS",
                "updatedAt": "2024-06-15T15:20:43-04:00",
                "bodyHtml": "Adidas collection",
                "publishedAt": "2024-05-26T02:48:46-04:00",
                "sortOrder": "best-selling",
                "templateSuffix": nil,
                "disjunctive": false,
                "rules": [
                    [
                        "column": "title",
                        "relation": "contains",
                        "condition": "ADIDAS"
                    ]
                ],
                "publishedScope": "web",
                "adminGraphqlApiId": "gid://shopify/Collection/422258540795",
                "image": [
                    "createdAt": "2024-05-26T02:48:46-04:00",
                    "alt": "",
                    "width": 1000,
                    "height": 676,
                    "src": "https://cdn.shopify.com/s/files/1/0702/9630/5915/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1716706126"
                ]
            ]
        ]
    ]
    enum ResponseWithError: Error {
        case responseError
    }
}

extension MockNetworkServices {
    func fetchBrands(completion: @escaping (Result<SmartCollectionsResponse, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(error: ResponseWithError.responseError))
            return
        }
        
        do {
            let brandData = try JSONSerialization.data(withJSONObject: fakeBrandObj, options: [])
            let brands = try JSONDecoder().decode(SmartCollectionsResponse.self, from: brandData)
            completion(.success(data: brands))
        } catch {
            completion(.failure(error: error))
        }
    }
}
