//
//  NetworkMonitor.swift
//  SportsApp
//
//  Created by user189298 on 5/14/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
import Network

class NetworkMonitor{
    
    static let shared = NetworkMonitor()
    let monitor : NWPathMonitor
    let queue = DispatchQueue.global()
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unKnown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unKnown
    }
    
    init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
            print(self?.isConnected ?? "N/A")
        }
    }
    
     
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }
        else{
            connectionType = .unKnown
        }
    }
    
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
}
