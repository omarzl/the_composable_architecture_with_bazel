//
//  Contact.swift
//  Demo
//
//  Created by Omar Zúñiga Lagunas on 16/07/24.
//

import Foundation

public struct Contact: Equatable, Identifiable {
  public let id: UUID
  public var name: String
  
  public init(id: UUID, name: String) {
    self.id = id
    self.name = name
  }
}
