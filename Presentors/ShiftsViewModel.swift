//
//  ShiftsViewModel.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation
import Combine

enum Status {
  case initialized, loading, finished
}

struct ErrorInfo: Identifiable {
  var id: Int
  let title: String
  let description: String
}

final class ShiftsViewModel: ObservableObject {
  @Published var selectedIndex: Int = 0
  @Published var dates: [String] = []
  @Published var list: [ShiftViewModel] = []
  @Published var statement: Result<Status, Error> = .success(.initialized)
  @Published var errorInfo: ErrorInfo?
  
  @Published var searchResult: [String: [ShiftViewModel]] = [:]
  
  private let fetchShiftsUseCase: FetchShiftsUseCaseProtocol
  private var cancellableSearch: AnyCancellable?
  private var cancellableBindings = Set<AnyCancellable>()
  
  init(fetchShiftsUseCase: FetchShiftsUseCaseProtocol) {
    self.fetchShiftsUseCase = fetchShiftsUseCase
    setupBindings()
  }
  
  func onSearch (
    request: ShiftsRequestEntity = ShiftsRequestEntity(address: "Dallas, TX", type: nil, start: nil, end: nil, radius: 15.8)
  ) {
    prepareForSearch()
    cancellableSearch = fetchShiftsUseCase.searchShifts(by: request)
      .map {
        $0.reduce(into: [String: [ShiftViewModel]](), {
          $0[$1.key] = $1.value.map { .init(model: $0) }
        })
      }
      .receive(on: RunLoop.main)
      .sink {[weak self] completion in
        switch completion {
        case .finished:
          self?.statement = .success(.finished)
        case .failure(let error):
          self?.statement = .failure(error)
        }
        
      } receiveValue: { [weak self] result in
        self?.dates = result.keys.sorted()
        self?.searchResult = result
        self?.selectedIndex = 0
      }
  }
  
  private func setupBindings() {
    $selectedIndex
      .map { [unowned self] index in
        self.dates[saveIndex: index] ?? ""
      }
      .map { [unowned self] key in
        self.searchResult[key] ?? []
      }
      .assign(to: \.list, on: self)
      .store(in: &cancellableBindings)
    
    $statement
      .map { result -> ErrorInfo? in
        guard case let .failure(error) = result else {
          return nil
        }
        return ErrorInfo(id: 1, title: "Ups, smth wrong".localized, description: error.localizedDescription)
      }
      .assign(to: \.errorInfo, on: self)
      .store(in: &cancellableBindings)
  }
  
  private func prepareForSearch() {
    cancellableSearch?.cancel()
    cancellableSearch = nil
    searchResult = [:]
    statement = .success(.loading)
  }
}

//private var request: URLRequest {
//  let url = URL(string: "https://staging-app.shiftkey.com/api/v2/available_shifts?address=Dallas%2C%20TX")!
//  var request = URLRequest(url: url)
//  let appJSON = "application/json"
//  request.addValue(appJSON, forHTTPHeaderField: "Content-Type")
//  request.addValue(appJSON, forHTTPHeaderField: "Accept")
//  return request
//}

