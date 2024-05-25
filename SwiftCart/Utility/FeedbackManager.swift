//
//  FeedbackManager.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 25/05/2024.
//

import Foundation
import SwiftMessages

class FeedbackManager{
    @MainActor static func rigularSwiftMessage(title : String, body : String){
        
        let messageView = MessageView.viewFromNib(layout: .tabView)
        messageView.configureTheme(.info)
        messageView.configureContent(title: title, body: body)

        SwiftMessages.show(config: SwiftMessages.Config(), view: messageView)
    }
}
