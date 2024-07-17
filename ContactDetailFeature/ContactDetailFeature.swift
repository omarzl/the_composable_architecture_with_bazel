//
//  ContactDetailFeature.swift
//  DemoTests
//
//  Created by Omar Zúñiga Lagunas on 17/07/24.
//

import ContactFoundation
import ComposableArchitecture

@Reducer
public struct ContactDetailFeature {
  @ObservableState
  public struct State: Equatable {
    public let contact: Contact
    @Presents var alert: AlertState<Action.Alert>?
    
    public init(contact: Contact) {
      self.contact = contact
    }
  }
  public enum Action {
    case alert(PresentationAction<Alert>)
    case delegate(Delegate)
    case deleteButtonTapped
    public enum Alert {
      case confirmDeletion
    }
    public enum Delegate {
      case confirmDeletion
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .alert(.presented(.confirmDeletion)):
        return .run { send in
          await send(.delegate(.confirmDeletion))
          await self.dismiss()
        }
      case .alert:
        return .none
      case .delegate:
        return .none
      case .deleteButtonTapped:
        state.alert = .confirmDeletion
        return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
  
  public init() {}
}

public extension AlertState where Action == ContactDetailFeature.Action.Alert {
  static let confirmDeletion = Self {
    TextState("Are you sure?")
  } actions: {
    ButtonState(role: .destructive, action: .confirmDeletion) {
      TextState("Delete")
    }
  }
}
