//
//  ShiftViewModel.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation
import Combine

final class ShiftViewModel: ObservableObject {
  var facility: FacilityType {
    model.facilityType
  }

  var skill: FacilityType {
    model.skill
  }

  var localizedSpeciality: LocalizedSpeciality {
    model.localizedSpeciality
  }
  
  var speciality: FacilityType {
    model.localizedSpeciality.speciality
  }
  
  var workingDate: String {
    Date.transform(date: model.normalizedStartDateTime)
  }
  
  var workingHours: String {
    let startHours = Date.transform(date: model.normalizedStartDateTime, formatOut: "HH:mm")
    let endHours = Date.transform(date: model.normalizedEndDateTime, formatOut: "HH:mm")
    return "\(startHours) - \(endHours)"
  }
  
  var startHours: Int {
    Date.transformToHour(date: model.normalizedStartDateTime)
  }
  
  var endHours: Int {
    Date.transformToHour(date: model.normalizedEndDateTime)
  }
  
  let model: ShiftEntity
  init(model: ShiftEntity) {
    self.model = model
  }
}

extension ShiftViewModel: Identifiable {
  public var id: Int { model.shiftID }
}
