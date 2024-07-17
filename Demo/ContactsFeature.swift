//
//  ContactsFeature.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import Foundation
import ComposableArchitecture
import ContactFoundation
import ContactDetailFeature

@Reducer
struct ContactsFeature {
  @ObservableState
  struct State: Equatable {
    var contacts: IdentifiedArrayOf<Contact> = []
    @Presents var destination: Destination.State?
    var path = StackState<ContactDetailFeature.State>()
  }
  enum Action {
    case addButtonTapped
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<ContactDetailFeature.State, ContactDetailFeature.Action>)
    case deleteButtonTapped(id: Contact.ID)
    enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }
  @Dependency(\.uuid) var uuid
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.destination = .addContact(
          AddContactFeature.State(
            contact: Contact(id: self.uuid(), name: "")
          )
        )
        return .none
      case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
        state.contacts.append(contact)
        return .none
      case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
        state.contacts.remove(id: id)
        return .none
      case .destination:
        return .none
      case let .deleteButtonTapped(id: id):
        state.destination = .alert(.deleteConfirmation(id: id))
        return .none
      case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
        guard let detailState = state.path[id: id]
        else { return .none }
        state.contacts.remove(id: detailState.contact.id)
        return .none
      case .path:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
    .forEach(\.path, action: \.path) {
      ContactDetailFeature()
    }
  }
}

extension ContactsFeature {
  @CasePathable
  @Reducer(state: .equatable)
  enum Destination {
    case addContact(AddContactFeature)
    case alert(AlertState<ContactsFeature.Action.Alert>)
  }
}

extension AlertState where Action == ContactsFeature.Action.Alert {
  static func deleteConfirmation(id: UUID) -> Self {
    Self {
      TextState("Are you sure?")
    } actions: {
      ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
        TextState("Delete")
      }
    }
  }
}
