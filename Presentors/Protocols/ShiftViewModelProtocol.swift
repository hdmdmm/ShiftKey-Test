//
//  ShiftViewModelProtocol.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 8.12.22.
//

import Foundation

protocol ShiftViewModelProtocol {
  var workingDate: String { get }
  var workingHours: String { get }
  var startHours: Int { get }
  var endHours: Int { get }
  var premiumRate: Bool { get }
  var covid: Bool { get }
  var shiftKind: String { get }
  
  var speciality: FacilityType { get }
  var facility: FacilityType { get }
  var skill: FacilityType { get }
  var localizedSpeciality: LocalizedSpeciality { get }
  var withinDistance: Int { get }
}

