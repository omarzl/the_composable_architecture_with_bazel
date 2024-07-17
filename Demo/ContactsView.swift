//
//  ContactsView.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
  @Perception.Bindable var store: StoreOf<ContactsFeature>
  
  var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      list
    } destination: { store in
      ContactDetailView(store: store)
    }
    .sheet(
      item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
    ) { addContactStore in
      NavigationStack {
        AddContactView(store: addContactStore)
      }
    }
    .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
  }
  
  var list: some View {
    List {
      ForEach(store.contacts) { contact in
        cellView(for: contact)
      }
    }
    .navigationTitle("Contacts")
    .toolbar {
      ToolbarItem {
        Button {
          store.send(.addButtonTapped)
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
  
  func cellView(for contact: Contact) -> some View {
    NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
      HStack {
        Text(contact.name)
        Spacer()
        Button {
          store.send(.deleteButtonTapped(id: contact.id))
        } label: {
          Image(systemName: "trash")
            .foregroundColor(.red)
        }
      }
    }
    .buttonStyle(.borderless)
  }
}
