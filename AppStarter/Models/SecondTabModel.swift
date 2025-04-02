//
//  SecondTabModel.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-04-02.
//
import SwiftUI
import SwiftUINavigation

@Observable
class AddItemModel: Identifiable {
    var id = 0
}

@Observable
class EditItemModel: Identifiable {
    var id = 1
}

@Observable
class SecondTabModel {
  var destination: Destination?

  @CasePathable
  enum Destination {
    case addItem(AddItemModel)
    case deleteItemAlert
    case editItem(EditItemModel)
  }
}
