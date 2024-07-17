//
//  AppFeatureTests.swift
//  DemoTests
//
//  Created by Omar Zúñiga Lagunas on 17/07/24.
//

import XCTest
import ComposableArchitecture
@testable import Demo

@MainActor
final class AppFeatureTests: XCTestCase {

  func testIncrementInFirstTab() async {
    let store = TestStore(initialState: AppFeature.State()) {
      AppFeature()
    }
    
    await store.send(\.tab1.incrementButtonTapped) {
      $0.tab1.count = 1
    }
  }
}
