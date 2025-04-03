//
//  SettingsModel.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-03.
//
import SwiftUI
import SwiftUINavigation


@Observable
class SettingsModel {
  var destination: Destination?

  @CasePathable
  enum Destination {
    case debugMenu
  }
}
