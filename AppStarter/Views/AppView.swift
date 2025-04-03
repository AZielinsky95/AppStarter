//
//  AppView.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//

import SwiftUI
import SwiftNavigation

struct AppView: View {
    @State var model: AppModel
    @EnvironmentObject var dependencies: AppDependencies
    
    var body: some View {
        TabView(selection: self.$model.selectedTab) {
            NavigationStack {
                Color.blue
            }
            .tag(AppModel.Tab.first)
            .tabItem {
                Label("First", systemImage: "arrow.forward")
            }
            
            NavigationStack {
                DetailView(model: .init())
            }
            .tag(AppModel.Tab.second)
            .tabItem {
                Label("Second", systemImage: "list.clipboard.fill")
            }
            
            NavigationStack {
                SettingsView(model: .init())
            }
            .tag(AppModel.Tab.third)
            .tabItem {
                Label("Settings", systemImage: "gear.circle.fill")
            }
        }
    }
}

#Preview {
  AppView(model: AppModel())
}
