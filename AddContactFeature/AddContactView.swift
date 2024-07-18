//
//  AddContactView.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import SwiftUI
import ComposableArchitecture

public struct AddContactView: View {
  @Perception.Bindable var store: StoreOf<AddContactFeature>
  
  public var body: some View {
    Form {
      TextField("Name", text: $store.contact.name.sending(\.setName))
      Button("Save") {
        store.send(.saveButtonTapped)
      }
    }
    .toolbar {
      ToolbarItem {
        Button("Cancel") {
          store.send(.cancelButtonTapped)
        }
      }
    }
  }
  
  public init(store: StoreOf<AddContactFeature>) {
    self.store = store
  }
}
