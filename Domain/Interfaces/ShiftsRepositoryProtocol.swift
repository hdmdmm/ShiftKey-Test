//
//  ShiftsRepositoryProtocol.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation
import Combine

protocol ShiftsRepositoryProtocol {
  func fetchShifts(by: ShiftsRequestEntity) -> AnyPublisher<[String: [ShiftEntity]], Error>
}

