//
//  AppModel.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-02.
//


import SwiftNavigation

@Observable
class AppModel {
  var selectedTab: Tab

  init(
    selectedTab: Tab = .first
  ) {
    self.selectedTab = selectedTab
  }

  enum Tab {
    case first
    case second
    case third
  }
}
