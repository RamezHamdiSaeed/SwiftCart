//
//  AppCommon.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 24/05/2024.
//

import Foundation


class AppCommon{
    static var networkingManager = NetworkingManagerImpl()
    static var feedbackManager = FeedbackManager()
    static var locationManager = LocationManager()
    static var userSessionManager = UserSessionManager()
}
