//  Reachability.swift
//  SwiftCart
//
//  Created by marwa on 23/06/2024.
//

import Foundation
import SystemConfiguration

class Reachability {

    static let shared = Reachability()

    private var reachability: SCNetworkReachability?
    private var reachabilityQueue = DispatchQueue(label: "com.yourapp.reachability")

    var isReachable: Bool {
        guard let reachability = self.reachability else { return false }

        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)

        // Check if reachable with the current flags
        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }

    private init() {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        self.reachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
    }

    deinit {
        SCNetworkReachabilitySetCallback(reachability!, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability!, nil)
    }

    func startMonitoring() {
        guard let reachability = self.reachability else { return }

        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        SCNetworkReachabilitySetCallback(reachability, { (_, flags, _) in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .reachabilityChanged, object: nil)
            }
        }, &context)

        SCNetworkReachabilitySetDispatchQueue(reachability, reachabilityQueue)
    }
}

extension Notification.Name {
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
}
