//
//  FetchShiftsUseCase.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation
import Combine

public protocol FetchShiftsUseCaseProtocol {
  func searchShifts(by: ShiftsRequestEntity) -> AnyPublisher<[String: [ShiftEntity]], Error>
}

struct FetchShiftUseCase {
  // TODO: if needed, to add a repository that stores the search results by request
//  private let shiftsDataRepository: ShiftsDataRepositoryProtocol
  private let shiftDataRepository: ShiftsRepositoryProtocol
  init(shiftDataRepository: ShiftsRepositoryProtocol) {
    self.shiftDataRepository = shiftDataRepository
  }
}

extension FetchShiftUseCase: FetchShiftsUseCaseProtocol {
  func searchShifts(by request: ShiftsRequestEntity) -> AnyPublisher<[String: [ShiftEntity]], Error> {
    // With existen ShiftsDataRepository try to fetch ShiftEntities from repo at first
    // then search Shifts on server
    shiftDataRepository.fetchShifts(by: request)
  }
}


