//
//  CounterFeature.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 15/07/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct CounterFeature {
  @ObservableState
  public struct State: Equatable {
    var id = UUID().uuidString
    public var count = 0
    public var fact: String?
    public var isLoading = false
    public var isTimerRunning = false
    
    public init() {}
  }
  
  public enum Action {
    case decrementButtonTapped
    case factButtonTapped
    case factResponse(String)
    case incrementButtonTapped
    case timerTick
    case toggleTimerButtonTapped
  }
  
  enum CancelID { case timer }
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.numberFact) var numberFact
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .decrementButtonTapped:
        state.count -= 1
        return .none
        
      case .factButtonTapped:
        state.fact = nil
        state.isLoading = true
        return .run { [count = state.count] send in
          try await send(.factResponse(self.numberFact.fetch(count)))
        }
        
      case let .factResponse(fact):
        state.fact = fact
        state.isLoading = false
        return .none
        
      case .incrementButtonTapped:
        state.count += 1
        return .none
        
      case .timerTick:
        state.count += 1
        return .none
        
      case .toggleTimerButtonTapped:
        state.isTimerRunning.toggle()
        if state.isTimerRunning {
          return .run { send in
            for await _ in self.clock.timer(interval: .seconds(1)) {
              await send(.timerTick)
            }
          }
          .cancellable(id: CancelID.timer)
        } else {
          return .cancel(id: CancelID.timer)
        }
      }
    }
  }
  
  public init() {}
}

