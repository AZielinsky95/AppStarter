//
//  NetworkMonitor.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-31.
//


import Combine
import Foundation
import Network

extension Notification.Name {
    static let networkConnectionChanged = Notification.Name("NetworkConnectionChanged")
}

@MainActor
class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    @Published private(set) var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            Task { @MainActor in
                self.isConnected = path.status == .satisfied
                NotificationCenter.default.post(name: .networkConnectionChanged, object: nil)
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
