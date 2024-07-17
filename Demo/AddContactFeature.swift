//
//  AddContactFeature.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import ComposableArchitecture
import ContactFoundation

@Reducer
struct AddContactFeature {
  @ObservableState
  struct State: Equatable {
    var contact: Contact
  }
  enum Action {
    case cancelButtonTapped
    case delegate(Delegate)
    case saveButtonTapped
    case setName(String)
    @CasePathable
    enum Delegate: Equatable {
      case saveContact(Contact)
    }
  }
  @Dependency(\.dismiss) var dismiss

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .cancelButtonTapped:
        return .run { _ in await self.dismiss() }
        
      case .delegate:
        return .none
        
      case .saveButtonTapped:
        return .run { [contact = state.contact] send in
          await send(.delegate(.saveContact(contact)))
          await self.dismiss()
        }
        
      case let .setName(name):
        state.contact.name = name
        return .none
      }
    }
  }
}
