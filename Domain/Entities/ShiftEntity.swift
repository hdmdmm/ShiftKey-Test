//
//  ShiftModel.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation

public struct FacilityType {
  let name: String
  let color: String
  let abbreviation: String?
}

public struct LocalizedSpeciality {
  let name: String
  let abreviation: String
  let speciality: FacilityType
}

public struct ShiftEntity {
  let shiftID: Int
  var normalizedStartDateTime: String
  var normalizedEndDateTime: String
  let timezone: String
  var premiumRate, covid: Bool
  let shiftKind: String
  let withinDistance: Int
  let facilityType: FacilityType
  let skill: FacilityType
  let localizedSpeciality: LocalizedSpeciality
}
