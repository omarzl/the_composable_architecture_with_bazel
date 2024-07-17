//
//  ContactDetailView.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 17/07/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
  @Perception.Bindable var store: StoreOf<ContactDetailFeature>
  
  var body: some View {
    Form {
      Button("Delete") {
        store.send(.deleteButtonTapped)
      }
    }
    .navigationTitle(Text(store.contact.name))
    .alert($store.scope(state: \.alert, action: \.alert))
  }
}
