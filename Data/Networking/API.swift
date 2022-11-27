//
//  API.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation

struct APIEndpoints {
  static func searchShifts(requestEntity: ShiftsRequestEntity) -> Endpoint<ShiftSearchResultDTO> {
    return Endpoint (
      path: "api/v2/available_shifts",
      method: .get,
      headers: ["Accept": "application/json",
                "Content-Type": "application/json"],
      queryParametersEncodable: requestEntity
    )
  }
}
