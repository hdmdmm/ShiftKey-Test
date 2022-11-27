//
//  DTOModels.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation

// MARK: - Root
struct ShiftSearchResultDTO: Codable {
  let data: [ShiftDataum]
  let meta: MetaDTO
}

extension ShiftSearchResultDTO {
  func toDomain() -> [String: [ShiftEntity]] {
    data.reduce(into: [String: [ShiftEntity]]()) {
      $0[$1.date] = $1.shifts.map{ $0.toDomain() }
    }
  }
}

// MARK: - ShiftDataum
struct ShiftDataum: Codable {
  let date: String
  let shifts: [ShiftDTO]
}

// MARK: - ShiftDTO
struct ShiftDTO: Codable {
  let shiftID: Int
  let startTime, endTime: String
  let normalizedStartDateTime, normalizedEndDateTime, timezone: String
  let premiumRate, covid: Bool
  let shiftKind: String
  let withinDistance: Int
  let facilityType: FacilityTypeDTO
  let skill: FacilityTypeDTO
  let localizedSpecialty: LocalizedSpecialtyDTO
  
  enum CodingKeys: String, CodingKey {
    case shiftID = "shift_id"
    case startTime = "start_time"
    case endTime = "end_time"
    case normalizedStartDateTime = "normalized_start_date_time"
    case normalizedEndDateTime = "normalized_end_date_time"
    case timezone
    case premiumRate = "premium_rate"
    case covid
    case shiftKind = "shift_kind"
    case withinDistance = "within_distance"
    case facilityType = "facility_type"
    case skill
    case localizedSpecialty = "localized_specialty"
  }
}

extension ShiftDTO {
  func toDomain() -> ShiftEntity {

    ShiftEntity(shiftID: shiftID,
                normalizedStartDateTime: normalizedStartDateTime,
                normalizedEndDateTime: normalizedEndDateTime,
                timezone: timezone,
                premiumRate: premiumRate,
                covid: covid,
                shiftKind: shiftKind,
                withinDistance: withinDistance,
                facilityType: facilityType.toDomain(),
                skill: skill.toDomain(),
                localizedSpeciality: localizedSpecialty.toDomain()
    )
  }
}

// MARK: - FacilityTypeDTO
struct FacilityTypeDTO: Codable {
  let id: Int
  let name: String
  let color: String
  let abbreviation: String?
}

extension FacilityTypeDTO {
  func toDomain() -> FacilityType {
    FacilityType(name: name,
                 color: color,
                 abbreviation: abbreviation)
  }
}

// MARK: - LocalizedSpecialtyDTO
struct LocalizedSpecialtyDTO: Codable {
  let id: Int
  let specialtyID: Int
  let stateID: Int
  let name: String
  let abbreviation: String
  let specialty: FacilityTypeDTO
  
  enum CodingKeys: String, CodingKey {
    case id
    case specialtyID = "specialty_id"
    case stateID = "state_id"
    case name, abbreviation, specialty
  }
}

extension LocalizedSpecialtyDTO {
  func toDomain() -> LocalizedSpeciality {
    LocalizedSpeciality(name: name,
                        abreviation: abbreviation,
                        speciality: specialty.toDomain())
  }
}

// MARK: - MetaDTO
struct MetaDTO: Codable {
  let lat: Double
  let lng: Double
}

