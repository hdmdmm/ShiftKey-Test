//
//  ShiftsDataRepository.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 24.11.22.
//

import Foundation
import Combine

protocol ShiftsDataSourceProtocol {
  func fetchShifts(by: ShiftsRequestEntity) -> AnyPublisher<[String: [ShiftEntity]], Error>
}

struct DefaultShiftsDataRepository: ShiftsRepositoryProtocol {
  let dataTransferService: DataTransferServiceProtocol
  let localDataSource: ShiftsDataSourceProtocol?

  init(
    dataTransferService: DataTransferServiceProtocol,
    localDataSource: ShiftsDataSourceProtocol? = nil
  ) {
    self.dataTransferService = dataTransferService
    self.localDataSource = localDataSource
  }
  
  /**
   1. try to get data from local storage
   2. try to get data from remote storage
   3. provide data to client
   4. update local data storage by received data from remote storage
   */

  func fetchShifts(by request: ShiftsRequestEntity) -> AnyPublisher<[String : [ShiftEntity]], Error> {
    guard let localDataSource = localDataSource else {
      return searchShifts(by: request)
    }

    return localDataSource.fetchShifts(by: request)
  }
  
  private func searchShifts(by request: ShiftsRequestEntity) -> AnyPublisher<[String: [ShiftEntity]], Error> {
    let endpoint = APIEndpoints.searchShifts(requestEntity: request)
    return dataTransferService.request(to: endpoint)
      .map { $0.toDomain() }
      .mapError( transform(_:) )
      .eraseToAnyPublisher()
  }
  
  private func transform(_ error: DataTransferError) -> Error {
    error as Error
  }
}
