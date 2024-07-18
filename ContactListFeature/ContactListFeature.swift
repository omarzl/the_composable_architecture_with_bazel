//
//  ContactListFeature.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import Foundation
import ComposableArchitecture
import ContactFoundation
import ContactDetailFeature
import AddContactFeature

@Reducer
public struct ContactListFeature {
  @ObservableState
  public struct State: Equatable {
    public var contacts: IdentifiedArrayOf<Contact> = []
    @Presents
    public var destination: Destination.State?
    var path = StackState<ContactDetailFeature.State>()
    
    public init(contacts: IdentifiedArrayOf<Contact> = []) {
      self.contacts = contacts
    }
  }
  public enum Action {
    case addButtonTapped
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<ContactDetailFeature.State, ContactDetailFeature.Action>)
    case deleteButtonTapped(id: Contact.ID)
    public enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }
  @Dependency(\.uuid) var uuid
  
  public var body: some ReducerOf<Self> {
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
  
  public init() {}
}

extension ContactListFeature {
  @CasePathable
  @Reducer(state: .equatable)
  public enum Destination {
    case addContact(AddContactFeature)
    case alert(AlertState<ContactListFeature.Action.Alert>)
  }
}

extension AlertState where Action == ContactListFeature.Action.Alert {
  public static func deleteConfirmation(id: UUID) -> Self {
    Self {
      TextState("Are you sure?")
    } actions: {
      ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
        TextState("Delete")
      }
    }
  }
}
