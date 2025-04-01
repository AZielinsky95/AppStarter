//
//  Router.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//

import SwiftUI

protocol Routable: ObservableObject {
    associatedtype RouteType: Hashable
    var path: [RouteType] { get set }
    var presentingSheet: Bool { get set }
    func push(_ route: RouteType)
    func pop()
    func reset()
}

class Router<T: Hashable>: Routable {
    @Published var path: [T] = []
    
    @Published var presentingSheet: Bool = false
    
    func push(_ route: T) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func reset() {
        path.removeAll()
    }
}
