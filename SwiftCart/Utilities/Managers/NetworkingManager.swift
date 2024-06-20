//
//  NetworkingManager.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 18/06/2024.
//

import Foundation

protocol NetworkingManager{
    func networkingRequest<T: Codable>(path: String, queryItems: [URLQueryItem]?, method: NetworkingMethods, requestBody: Codable?, completeBaseURL:String? , networkResponse: @escaping (Result<T, NetworkError>) -> Void)
    
}
