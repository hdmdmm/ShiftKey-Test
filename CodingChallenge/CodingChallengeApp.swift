//
//  CodingChallengeApp.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI

@main
struct CodingChallengeApp: App {
  private var container = DIContainer()
  var body: some Scene {
    WindowGroup {
      ShiftsView(viewModel: container.makeShiftsViewModel())
    }
  }
}
