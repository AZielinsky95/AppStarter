//
//  ContentView.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//

import SwiftUI

struct ContentView: View {
   @StateObject private var appRouter = Router<AppRoute>()
   @StateObject private var detailRouter = Router<DetailRoute>()
    
    var body: some View {

        NavigationStack(path: $appRouter.path) {
            VStack {
                Text("Home Screen")
                
                Button("Go to Detail") {
                    appRouter.presentingSheet = true
                }
                
                Button("Go to Settings") {
                    appRouter.push(.settings)
                }
            }
            .onChange(of: appRouter.path, { oldValue, newValue in
                print("app path changed from \(oldValue) to \(newValue)")
            })
            .sheet(isPresented: $appRouter.presentingSheet, content: {
                DetailView(itemId: 10)
                .environmentObject(appRouter)
                .environmentObject(detailRouter)
            })
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .detail(let id):
                    Color.red
                case .settings:
                    Color.green
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct DetailView: View {
    let itemId: Int
    @EnvironmentObject private var appRouter: Router<AppRoute>
    @EnvironmentObject private var detailRouter: Router<DetailRoute>
    
    var body: some View {
        NavigationStack(path: $detailRouter.path) {
            VStack {
                Text("Detail Screen")
                
                Button("Go home") {
                    appRouter.pop()
                }
                
                Button("Go to subpage") {
                    detailRouter.push(.subpage1(id: 10))
                }
            }
            .onChange(of: detailRouter.path, { oldValue, newValue in
                print("detail path changed from \(oldValue) to \(newValue)")
            })
            .navigationDestination(for: DetailRoute.self) { route in
                switch route {
                case .subpage1(let id):
                    Color.red.overlay {
                        Text("\(id)")
                    }
                case .subpage2(let id):
                    Color.blue.overlay {
                        Text("\(id)")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
