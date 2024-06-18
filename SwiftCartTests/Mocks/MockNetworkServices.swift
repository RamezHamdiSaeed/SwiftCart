//
//  MockNetworkServices.swift
//  SwiftCartTests
//
//  Created by marwa on 16/06/2024.
//
//

import Foundation
@testable import SwiftCart
//
//class MockNetworkServices {
//    var shouldReturnError: Bool
//
//    init(shouldReturnError: Bool) {
//        self.shouldReturnError = shouldReturnError
//    }
//
//    let fakeBrandObj: [String: Any] = [
//        "smartCollections": [
//            [
//                "id": 422258540795,
//                "handle": "adidas",
//                "title": "ADIDAS",
//                "updatedAt": "2024-06-15T15:20:43-04:00",
//                "bodyHtml": "Adidas collection",
//                "publishedAt": "2024-05-26T02:48:46-04:00",
//                "sortOrder": "best-selling",
//                "templateSuffix": nil,
//                "disjunctive": false,
//                "rules": [
//                    [
//                        "column": "title",
//                        "relation": "contains",
//                        "condition": "ADIDAS"
//                    ]
//                ],
//                "publishedScope": "web",
//                "adminGraphqlApiId": "gid://shopify/Collection/422258540795",
//                "image": [
//                    "createdAt": "2024-05-26T02:48:46-04:00",
//                    "alt": "",
//                    "width": 1000,
//                    "height": 676,
//                    "src": "https://cdn.shopify.com/s/files/1/0702/9630/5915/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1716706126"
//                ]
//            ]
//        ]
//    ]
//    enum ResponseWithError: Error {
//        case responseError
//    }
//}
//
//extension MockNetworkServices {
//    func fetchBrands(completion: @escaping (Result<SmartCollectionsResponse, Error>) -> Void) {
//        if shouldReturnError {
//            completion(.failure(error: ResponseWithError.responseError))
//            return
//        }
//
//        do {
//            let brandData = try JSONSerialization.data(withJSONObject: fakeBrandObj, options: [])
//            let brands = try JSONDecoder().decode(SmartCollectionsResponse.self, from: brandData)
//            completion(.success(data: brands))
//        } catch {
//            completion(.failure(error: error))
//        }
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
    let fakeProductResponseObj: [String: Any] = [
        "products": [
            [
                "id": 8624931733755,
                "title": "ADIDAS | CLASSIC BACKPACK",
                "bodyHtml": "This women's backpack has a glam look, thanks to a faux-leather build with an allover fur print. The front zip pocket keeps small things within reach, while an interior divider reins in potential chaos.",
                "vendor": "ADIDAS",
                "productType": "ACCESSORIES",
                "createdAt": "2024-05-26T02:47:44-04:00",
                "handle": "adidas-classic-backpack",
                "updatedAt": "2024-06-15T14:55:54-04:00",
                "publishedAt": "2024-05-26T02:47:44-04:00",
                "templateSuffix": nil,
                "publishedScope": "global",
                "tags": "adidas, backpack, egnition-sample-data",
                "status": "active",
                "adminGraphqlApiId": "gid://shopify/Product/8624931733755",
                "variants": [
                    [
                        "id": 46036216611067,
                        "productId": 8624931733755,
                        "title": "OS / black",
                        "price": "70.00",
                        "sku": "AD-03-black-OS",
                        "position": 1,
                        "inventoryPolicy": "deny",
                        "compareAtPrice": nil,
                        "fulfillmentService": "manual",
                        "inventoryManagement": "shopify",
                        "option1": "OS",
                        "option2": "black",
                        "option3": nil,
                        "createdAt": "2024-05-26T02:47:45-04:00",
                        "updatedAt": "2024-06-15T14:52:27-04:00",
                        "taxable": true,
                        "barcode": nil,
                        "grams": 0,
                        "weight": 0,
                        "weightUnit": "kg",
                        "inventoryItemId": 48100325720315,
                        "inventoryQuantity": 5,
                        "oldInventoryQuantity": 5,
                        "requiresShipping": true,
                        "adminGraphqlApiId": "gid://shopify/ProductVariant/46036216611067",
                        "imageId": nil
                    ]
                ],
                "options": [
                    [
                        "id": 11058812879099,
                        "productId": 8624931733755,
                        "name": "Size",
                        "position": 1,
                        "values": ["OS"]
                    ],
                    [
                        "id": 11058812911867,
                        "productId": 8624931733755,
                        "name": "Color",
                        "position": 2,
                        "values": ["black"]
                    ]
                ],
                "images": [
                    [
                        "id": 42882511307003,
                        "alt": nil,
                        "position": 1,
                        "productId": 8624931733755,
                        "createdAt": "2024-05-26T02:47:44-04:00",
                        "updatedAt": "2024-05-26T02:47:44-04:00",
                        "adminGraphqlApiId": "gid://shopify/ProductImage/42882511307003",
                        "width": 635,
                        "height": 560,
                        "src": "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/85cc58608bf138a50036bcfe86a3a362.jpg?v=1716706064",
                        "variantIds": []
                    ],
                    [
                        "id": 42882511339771,
                        "alt": nil,
                        "position": 2,
                        "productId": 8624931733755,
                        "createdAt": "2024-05-26T02:47:44-04:00",
                        "updatedAt": "2024-05-26T02:47:44-04:00",
                        "adminGraphqlApiId": "gid://shopify/ProductImage/42882511339771",
                        "width": 635,
                        "height": 560,
                        "src": "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/8a029d2035bfb80e473361dfc08449be.jpg?v=1716706064",
                        "variantIds": []
                    ],
                    [
                        "id": 42882511372539,
                        "alt": nil,
                        "position": 3,
                        "productId": 8624931733755,
                        "createdAt": "2024-05-26T02:47:44-04:00",
                        "updatedAt": "2024-05-26T02:47:44-04:00",
                        "adminGraphqlApiId": "gid://shopify/ProductImage/42882511372539",
                        "width": 635,
                        "height": 560,
                        "src": "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/ad50775123e20f3d1af2bd07046b777d.jpg?v=1716706064",
                        "variantIds": []
                    ]
                ],
                "image": [
                    "id": 42882511307003,
                    "alt": nil,
                    "position": 1,
                    "productId": 8624931733755,
                    "createdAt": "2024-05-26T02:47:44-04:00",
                    "updatedAt": "2024-05-26T02:47:44-04:00",
                    "adminGraphqlApiId": "gid://shopify/ProductImage/42882511307003",
                    "width": 635,
                    "height": 560,
                    "src": "https://cdn.shopify.com/s/files/1/0702/9630/5915/files/85cc58608bf138a50036bcfe86a3a362.jpg?v=1716706064",
                    "variantIds": []
                ]
            ]
        ]
    ]
    let fakeOrderObj: [String: Any] = [
            "orders": [
                [
                    "id": 5628432744699,
                    "adminGraphqlApiId": "gid://shopify/Order/5628432744699",
                    "appId": 1608003,
                    "browserIp": nil,
                    "buyerAcceptsMarketing": false,
                    "cancelReason": nil,
                    "cancelledAt": nil,
                    "cartToken": nil,
                    "checkoutId": nil,
                    "checkoutToken": nil,
                    "clientDetails": nil,
                    "closedAt": nil,
                    "company": nil,
                    "confirmationNumber": "5WXRL0090",
                    "confirmed": true,
                    "contactEmail": "egnition_sample_77@egnition.com",
                    "createdAt": "2024-05-26T02:53:39-04:00",
                    "currency": "EGP",
                    "currentSubtotalPrice": "0.30",
                    "currentSubtotalPriceSet": [
                        "shopMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "currentTotalDiscounts": "0.00",
                    "currentTotalDiscountsSet": [
                        "shopMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "currentTotalDutiesSet": nil,
                    "currentTotalPrice": "0.30",
                    "currentTotalPriceSet": [
                        "shopMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "currentTotalTax": "0.00",
                    "currentTotalTaxSet": [
                        "shopMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "customerLocale": "en",
                    "deviceId": nil,
                    "discountCodes": [],
                    "email": "egnition_sample_77@egnition.com",
                    "financialStatus": "paid",
                    "fulfillmentStatus": nil,
                    "gateway": "bogus",
                    "landingSite": nil,
                    "landingSiteRef": nil,
                    "locationId": nil,
                    "merchantOfRecordAppId": nil,
                    "name": "#1008",
                    "note": nil,
                    "noteAttributes": [],
                    "number": 8,
                    "orderNumber": 1008,
                    "orderStatusUrl": "https://checkout.shopify.com/970296305915/orders/f2b1d9a3fc04aa68b2d809f2b911d947/authenticate?key=1a11a355a7adf7e10ebaae020cc84d22",
                    "originalTotalDutiesSet": nil,
                    "paymentGatewayNames": ["bogus"],
                    "phone": nil,
                    "presentmentCurrency": "EGP",
                    "processedAt": "2024-05-26T02:53:39-04:00",
                    "processingMethod": "direct",
                    "reference": "5WXRL0090",
                    "referringSite": nil,
                    "sourceIdentifier": nil,
                    "sourceName": "private",
                    "sourceUrl": nil,
                    "subtotalPrice": "0.30",
                    "subtotalPriceSet": [
                        "shopMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "tags": "",
                    "taxLines": [],
                    "taxesIncluded": false,
                    "test": true,
                    "token": "f2b1d9a3fc04aa68b2d809f2b911d947",
                    "totalDiscounts": "0.00",
                    "totalDiscountsSet": [
                        "shopMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "totalLineItemsPrice": "0.30",
                    "totalLineItemsPriceSet": [
                        "shopMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "totalOutstanding": "0.00",
                    "totalPrice": "0.30",
                    "totalPriceSet": [
                        "shopMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.30",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "totalPriceUsd": "0.02",
                    "totalShippingPriceSet": [
                        "shopMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "totalTax": "0.00",
                    "totalTaxSet": [
                        "shopMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ],
                        "presentmentMoney": [
                            "amount": "0.00",
                            "currencyCode": "EGP"
                        ]
                    ],
                    "totalTipReceived": "0.00",
                    "totalWeight": 0,
                    "updatedAt": "2024-05-26T02:53:40-04:00",
                    "userId": nil
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
    
    func fetchProducts (collectionId : Int ,completionHandler completion: @escaping (Result<ProductResponse,Error>) -> Void){
        if shouldReturnError {
            completion(.failure(error: ResponseWithError.responseError))
            return
        }
        
        do {
            let productsData = try JSONSerialization.data(withJSONObject: fakeProductResponseObj, options: [])
            let products = try JSONDecoder().decode(ProductResponse.self, from: productsData)
            completion(.success(data: products))
        } catch {
            completion(.failure(error: error))
        }
    }
   
    func fetchOrders (customerId :  String, completionHandler completion: @escaping (Result<OrdersResponse,Error>) -> Void){
        if shouldReturnError {
            completion(.failure(error: ResponseWithError.responseError))
            return
        }
        do {
            let ordersData = try JSONSerialization.data(withJSONObject: fakeOrderObj, options: [])
            let orders = try JSONDecoder().decode(OrdersResponse.self, from: ordersData)
            completion(.success(data: orders))
        } catch {
            completion(.failure(error: error))
        }
    }
}
