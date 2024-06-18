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


extension FeedbackManager{
    func showAlert(alertTitle:String,alertMessage:String,alertStyle:UIAlertController.Style,view : UIViewController) {
          let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let attributedTitle = NSAttributedString(string: alertTitle, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.systemOrange
        ])
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        
          let okAction = UIAlertAction(title: "OK", style: .default) { _ in
              print("OK tapped")
            
          }
        
          alertController.addAction(okAction)
      //  present(alertController)
        view.present(alertController, animated: true, completion: nil)
      }
    
    func showCancelableAlert(alertTitle:String,alertMessage:String,alertStyle:UIAlertController.Style,view : UIViewController , okCompletion : @escaping () -> Void ) {
          let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let attributedTitle = NSAttributedString(string: alertTitle, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.systemOrange // Change color as needed
        ])
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("cancel tapped")
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
              print("OK tapped")
            okCompletion()
          }
          alertController.addAction(okAction)

      //  present(alertController)
        view.present(alertController, animated: true, completion: nil)
      }
}
