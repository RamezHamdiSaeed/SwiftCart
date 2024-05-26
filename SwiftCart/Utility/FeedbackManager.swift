//
//  FeedbackManager.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 25/05/2024.
//

import Foundation
import SwiftMessages

class FeedbackManager{
    @MainActor static func errorSwiftMessage(title : String, body : String){
        
        let messageView = MessageView.viewFromNib(layout: .tabView)
        messageView.configureTheme(.error)
        messageView.configureContent(title: title, body: body)
        messageView.button?.setTitle("OK", for: .normal)

        SwiftMessages.show(config: SwiftMessages.Config(), view: messageView)
    }
    
    @MainActor static func successSwiftMessage(title : String, body : String){
        
        let messageView = MessageView.viewFromNib(layout: .tabView)
        messageView.configureTheme(.success)
        messageView.configureContent(title: title, body: body)
        messageView.button?.setTitle("OK", for: .normal)

        SwiftMessages.show(config: SwiftMessages.Config(), view: messageView)
    }
}
