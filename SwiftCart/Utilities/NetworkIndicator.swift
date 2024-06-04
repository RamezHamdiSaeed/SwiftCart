//
//  NetworkIndicator.swift
//  SwiftCart
//
//  Created by marwa on 30/05/2024.
//

import Foundation
import UIKit
 
class NetworkIntecator{
    static var networkIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    static func startAnimating(view:UIView){

            networkIndicator = UIActivityIndicatorView(style: .large)
            let biggerSize = CGSize(width: 100, height: 100)
            networkIndicator.frame = CGRect(origin: .zero, size: biggerSize)
            networkIndicator.color = .yellow
            networkIndicator.center = view.center
            view.addSubview(networkIndicator)
            networkIndicator.startAnimating()
    }
    
    static func stopAnimation(){
            networkIndicator.stopAnimating()
    }
}
