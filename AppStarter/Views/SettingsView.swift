//
//  SettingsView.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-03.
//

import SwiftUI
import DebugMenu

struct SettingsView: View {

    @State var model: SettingsModel
    @StateObject var debugMenuDataSource = DebugMenuDataSource.shared

    var body: some View {
        List {
            Button {
                model.destination = .debugMenu
            } label: {
                Text("Debug Menu")
            }
        }
        .navigationDestination(item: $model.destination.debugMenu) {
            DebugMenuView(dataSource: debugMenuDataSource)
        }
    }
}
