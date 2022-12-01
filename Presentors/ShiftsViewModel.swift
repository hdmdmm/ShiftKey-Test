//
//  ShiftsViewModel.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation
import Combine

protocol ShiftsViewModelProtocol: ObservableObject {
  var selectedIndex: Int { get set }
  var dates: [String] { get set }
  var list: [ShiftViewModel] { get set }
  var errorInfo: ErrorInfo? { get set }
  var isSearching: Bool { get set }
  var searchRequestSettings: ShiftsRequestEntity { get set }

  func doSearch (request: ShiftsRequestEntity)
  func doSearch()
}

final class ShiftsViewModel: ShiftsViewModelProtocol {
  @Published var selectedIndex: Int = 0
  @Published var dates: [String] = []
  @Published var list: [ShiftViewModel] = []
  @Published var errorInfo: ErrorInfo?
  @Published var isSearching: Bool = false
  @Published var searchRequestSettings: ShiftsRequestEntity
  
  @Published private var searchResult: [String: [ShiftViewModel]] = [:]
  @Published private var statement: Result<Status, Error> = .success(.initialized)
  
  private let fetchShiftsUseCase: FetchShiftsUseCaseProtocol
  private var cancellableSearch: AnyCancellable?
  private var cancellableBindings = Set<AnyCancellable>()
  
  init(fetchShiftsUseCase: FetchShiftsUseCaseProtocol) {
    self.fetchShiftsUseCase = fetchShiftsUseCase
    searchRequestSettings = ShiftsRequestEntity(address: "Dallas, TX",
                                                type: nil,
                                                start: nil,
                                                end: nil,
                                                radius: 15.8)
    setupBindings()
  }
  
  @available(*, deprecated, message: "Added while search settings view and vm logic under development")
  func doSearch() {
    doSearch(
      request: ShiftsRequestEntity(address: "Dallas, TX", type: nil, start: nil, end: nil, radius: 15.8)
    )
  }
  
  func doSearch (
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
    
    $statement
      .map {
        guard case let .success(statement) = $0 else {
          return false
        }
        return statement == .loading
      }
      .assign(to: \.isSearching, on: self)
      .store(in: &cancellableBindings)
      
  }
  
  private func prepareForSearch() {
    cancellableSearch?.cancel()
    cancellableSearch = nil
    searchResult = [:]
    statement = .success(.loading)
  }
}

