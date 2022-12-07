//
//  DIContainer.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation
import UIKit

struct ApplicationConfig: Decodable {
  let host: String
  // TODO: To add configuration parameter of backend API, version
}

struct DIContainer: ConfiguratorProtocol {
  private(set) var model: ApplicationConfig
  private(set) var hostURL: URL
//  private(set) var coordinator: FlowCoordinatorProtocol
  
  init() {
    guard let config = try? Self.load("Config") else {
      fatalError(" The config must be provided by CI/DI at the pre building processing ")
    }
    model = config
    guard let url = URL(string: config.host) else {
      fatalError(" The app config has invalid host url")
    }
    hostURL = url
    
//    coordinator = MainFlowCoordinator()
    // appearance
    UITableView.appearance().separatorColor = .clear
  }
  
  func makeNetworkConfig() -> NetworkConfigurable {
    ApiDataNetworkConfig(baseURL: hostURL, headers: [:], queryParameters: [:])
  }
  
  func makeNetworkService() -> NetworkServiceProtocol {
    DefaultNetworkService(networkConfig: makeNetworkConfig())
  }
  
  func makeDataTransferService() -> DataTransferServiceProtocol {
    DefaultDataTransferService(networkService: makeNetworkService())
  }

  func makeSearchShiftsDataService() -> ShiftsRepositoryProtocol {
    DefaultShiftsDataRepository(dataTransferService: makeDataTransferService())
  }
  
  func makeUseCase() -> FetchShiftsUseCaseProtocol {
    FetchShiftUseCase(shiftDataRepository: makeSearchShiftsDataService())
  }
  
  func makeShiftsViewModel() -> ShiftsViewModel {
    ShiftsViewModel(fetchShiftsUseCase: makeUseCase())
  }
  
  func makeRootView() -> ShiftsView<ShiftsViewModel> {
    ShiftsView(viewModel: makeShiftsViewModel())
  }
}
