//
//  ContactDetailView.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 17/07/24.
//

import SwiftUI
import ComposableArchitecture

public struct ContactDetailView: View {
  @Perception.Bindable var store: StoreOf<ContactDetailFeature>
  
  public var body: some View {
    Form {
      Button("Delete") {
        store.send(.deleteButtonTapped)
      }
    }
    .navigationTitle(Text(store.contact.name))
    .alert($store.scope(state: \.alert, action: \.alert))
  }
  
  public init(store: StoreOf<ContactDetailFeature>) {
    self.store = store
  }
}
