//
//  AppView.swift
//  DemoTCA
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import SwiftUI
import ComposableArchitecture
import ContactListFeature
import AddContactFeature
import CounterFeature

struct AppView: View {
  let store: StoreOf<AppFeature>
  let store2: StoreOf<ContactListFeature>
  
  var body: some View {
    TabView {
      ContactsView(store: store2)
        .tabItem {
          Text("Contacts")
        }
      
      CounterView(store: store.scope(state: \.tab1, action: \.tab1))
        .tabItem {
          Text("Counter 1")
        }
      
      CounterView(store: store.scope(state: \.tab2, action: \.tab2))
        .tabItem {
          Text("Counter 2")
        }
    }
  }
}
