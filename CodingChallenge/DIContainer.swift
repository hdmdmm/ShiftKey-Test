//
//  DIContainer.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 22.11.22.
//

import Foundation
import UIKit

struct DIContainer {
  private(set) var configurator: AppConfigurator
  
  init() {

    guard let configurator = try? AppConfigurator(fileName: "AppConfig")
    else {
      fatalError(" The config must be provided by CI/DI at the pre-building processing ")
    }

    self.configurator = configurator

    // appearance
    UITableView.appearance().separatorColor = .clear
  }
  
  func makeNetworkConfig() -> NetworkConfigurable {
    ApiDataNetworkConfig(baseURL: configurator.hostURL, headers: [:], queryParameters: [:])
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
