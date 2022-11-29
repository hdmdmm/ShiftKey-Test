//
//  SearchSettingsViewModel.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 29.11.22.
//

import Foundation
import Combine

enum PeriodType: String {
  case week
  case fourDay = "4day"
  case list
}

class SearchSettingsViewModel: ObservableObject {
  @Published var address: String = "Dallas, TX"
  @Published var distance: Double = 15.8
  @Published var type: PeriodType = .list
  @Published var startDate: String = Date().transform()
  @Published var endDate: String = Date(timeInterval: 60*60*24*7*5, since: Date()).transform()
}
