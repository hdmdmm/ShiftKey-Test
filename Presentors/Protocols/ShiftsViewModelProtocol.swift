//
//  ShiftsViewModelProtocol.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 8.12.22.
//

import Foundation

protocol ShiftsViewModelProtocol: ObservableObject {
  var selectedIndex: Int { get set }
  var dates: [String] { get set }
  var list: [ShiftViewModel] { get set }
  var errorInfo: ErrorInfo? { get set }
  var isSearching: Bool { get set }
  var searchRequestSettings: ShiftsRequestEntity { get set }

  func doSearch (request: ShiftsRequestEntity)
  func doSearch()
}
