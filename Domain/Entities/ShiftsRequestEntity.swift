//
//  ShiftsRequestEntity.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation

public enum TimePeriodType: String, Encodable {
  case week, list
  case fourDays = "4day"
}

public struct ShiftsRequestEntity: Encodable {
  let address: String
  var type: TimePeriodType?
  var start: String?
  var end: String?
  var radius: Float?
}
