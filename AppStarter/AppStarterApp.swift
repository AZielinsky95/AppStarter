//
//  AppStarterApp.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//

import SwiftUI

class AppDependencies: ObservableObject {
    let api: any Networking
    let exampleService: any ExampleServicing
    
    public init(api: any Networking, exampleService: any ExampleServicing) {
        self.api = api
        self.exampleService = exampleService
    }
}

@main
struct AppStarterApp: App {
    @StateObject var dependencies: AppDependencies

    init() {
        let api = API()
        let dependencies = AppDependencies(api: api, exampleService: ExampleService(api: api))
        _dependencies = StateObject(wrappedValue: dependencies)
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(model: AppModel())
                .environmentObject(dependencies)
        }
    }
}
