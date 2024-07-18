//
//  DemoApp.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 15/07/24.
//

import ComposableArchitecture
import SwiftUI
import ContactListFeature

@main
struct DemoApp: App {
  static let store = Store(initialState: AppFeature.State()) {
    AppFeature()
      ._printChanges()
  }
  
  static let store2 = Store(initialState: ContactListFeature.State()) {
    ContactListFeature()
      ._printChanges()
  }
  
  var body: some Scene {
    WindowGroup {
      AppView(store: DemoApp.store, store2: DemoApp.store2)
    }
  }
}
