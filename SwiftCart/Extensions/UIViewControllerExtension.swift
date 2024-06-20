//
//  UIViewControllerExtension.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 20/06/2024.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showSnackbar(message: String) {
        let snackbarHeight: CGFloat = 50.0
        let snackbar = UILabel(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: snackbarHeight))
        snackbar.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        snackbar.textColor = .white
        snackbar.textAlignment = .center
        snackbar.text = message
        snackbar.font = UIFont.systemFont(ofSize: 16)
        snackbar.alpha = 0.0
        
        view.addSubview(snackbar)
        
        UIView.animate(withDuration: 0.3, animations: {
            snackbar.frame.origin.y -= snackbarHeight
            snackbar.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseInOut, animations: {
                snackbar.frame.origin.y += snackbarHeight
                snackbar.alpha = 0.0
            }) { _ in
                snackbar.removeFromSuperview()
            }
        }
    }
    
}
