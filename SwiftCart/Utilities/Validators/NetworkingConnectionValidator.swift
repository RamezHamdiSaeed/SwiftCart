//
//  NetworkingConnectionValidator.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 19/06/2024.
//

import Foundation
import Reachability

class NetworkingConnectionValidator{
    
    static var reachability: Reachability!
    
    static func setupReachability(whenUnReachableToInternet: @escaping () -> Void) {
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            whenUnReachableToInternet()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    static func stopReachabilityNotifier() {
        reachability.stopNotifier()
    }

}

extension UIViewController {
    
    func notifyUserAboutConnection() {
        NetworkingConnectionValidator.setupReachability {
            DispatchQueue.main.async {
                FeedbackManager.errorSwiftMessage(title: "Prompt", body: "No Internet Found , try again later")

            }
        }
    }
    
    func startMonitoringConnection() {
        NetworkingConnectionValidator.setupReachability {
            DispatchQueue.main.async {
                FeedbackManager.errorSwiftMessage(title: "Prompt", body: "No Internet Found , try again later")

            }
        }
    }
    
    func stopMonitoringConnection() {
        NetworkingConnectionValidator.stopReachabilityNotifier()
    }
}
