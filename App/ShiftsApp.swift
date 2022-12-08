//
//  CodingChallengeApp.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI

@main
struct ShiftsApp: App {
  private var container = DIContainer()
  var body: some Scene {
    WindowGroup {
      container.makeRootView()
    }
  }
}
