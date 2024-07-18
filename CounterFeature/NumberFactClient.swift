//
//  NumberFactClient.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import Foundation
import ComposableArchitecture

public struct NumberFactClient {
  public var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
  public static let liveValue = Self(
    fetch: { number in
      let (data, _) = try await URLSession.shared
        .data(from: URL(string: "http://numbersapi.com/\(number)")!)
      return String(decoding: data, as: UTF8.self)
    }
  )
}

extension DependencyValues {
  public var numberFact: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}
