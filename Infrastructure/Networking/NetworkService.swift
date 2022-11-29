//
//  NetworkService.swift
//  MVVMC
//
//  Created by Dmitry Kh on 17.09.22.
//

import Foundation
import Combine

public enum NetworkError: LocalizedError {
  case error(statusCode: Int, data: Data?)
  case notConnected
  case cancelled
  case generic(Error)
  case urlGeneration

  public var errorDescription: String? {
    let description: String
    switch self {
    case .error(statusCode: let status, let data):
      description = "Responsed: status: \(status) " + "data: \(String(data: data ?? Data(), encoding: .utf8) ?? "")"
    case .notConnected:
      description = "Lost network connection."
    case .cancelled:
      description = "The request was cancelled."
    case .generic(let error):
      description = error.localizedDescription
    case .urlGeneration:
      description = "The requested url and parameters are incorrect"
    }
    return description.localized
  }
}

public protocol NetworkServiceProtocol {
  func request(endpoint: Requestable) -> AnyPublisher<Data, NetworkError>
}

public struct DefaultNetworkService {
  private let sessionManager: NetworkSessionManagerProtocol
  private let networkConfig: NetworkConfigurable
  init(
    networkConfig: NetworkConfigurable,
    sessionManager: NetworkSessionManagerProtocol = DefaultNetworkSessionManager()
  ) {
    self.networkConfig = networkConfig
    self.sessionManager = sessionManager
  }
}

extension DefaultNetworkService: NetworkServiceProtocol {
  public func request(endpoint: Requestable) -> AnyPublisher<Data, NetworkError> {
    
    do {
      let urlRequest = try endpoint.urlRequest(with: networkConfig)
      return sessionManager.dataTask(request: urlRequest)
        .tryMap(transform(_:))
        .mapError(transform(_:))
        .map { $0.data }
        .eraseToAnyPublisher()
    }
    catch {
      return Fail(error: NetworkError.urlGeneration).eraseToAnyPublisher()
    }
  }
  
  private func transform(_ error: Error) -> NetworkError {
    if let error = error as? NetworkError {
      return error
    }
    guard let error = error as? URLError else {
      return .generic(error)
    }
    if error.code == .notConnectedToInternet {
      return .notConnected
    }
    if error.code == .cancelled {
      return .cancelled
    }
    if error.code == .badURL || error.code == .unsupportedURL {
      return .urlGeneration
    }
    return .generic(error)
  }
  
  private func transform(_ element: (data: Data, response: URLResponse)) throws -> (data: Data, response: URLResponse) {
    guard
      let statusCode = (element.response as? HTTPURLResponse)?.statusCode,
      !((200..<300) ~= statusCode)
    else {
      return element
    }
    throw NetworkError.error(statusCode: statusCode, data: element.data)
  }
}
