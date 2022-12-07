//
//  AppConfigurator.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 7.12.22.
//

import Foundation

struct AppConfigModel: Decodable {
  let host: String
  // TODO: To add configuration parameter of backend API, version
}

struct AppConfigurator: ConfiguratorProtocol {
  let model: AppConfigModel
  let hostURL: URL
  init(fileName: String) throws {
    model = try Self.load(fileName)
    
    guard let url = URL(string: model.host) else {
      throw ConfiguratorErrors.configDataMismatch
    }

    hostURL = url
  }
}
