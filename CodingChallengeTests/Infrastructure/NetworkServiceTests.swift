//
//  NetworkServiceTests.swift
//  CodingChallengeTests
//
//  Created by Dmitry Kh on 29.11.22.
//

import XCTest
import Combine
@testable import CodingChallenge

class NetworkServiceTests: XCTestCase {
  var mockedSessionManager: MockNetworkSessionManager?
  var networkService: DefaultNetworkService?
  let mockConfig = MockAPIConfig(baseURL: URL(string: "http://some.host.com")!, headers: [:], queryParameters: [:])

  override func setUpWithError() throws {
    let mockedSessionManager = MockNetworkSessionManager()

    networkService = try XCTUnwrap(
      DefaultNetworkService(
        networkConfig: mockConfig,
        sessionManager: mockedSessionManager
      ), "The tests require DefaultNetworkService")

    self.mockedSessionManager = mockedSessionManager
  }
  
  override func tearDownWithError() throws {}
  
  func testNetworkService_failedStatusCode() throws {
    let url = try XCTUnwrap(
      URL(string: "http://some.host.com/endpoint"),
      "Couldn't create an URL"
    )
    let response = try XCTUnwrap(
      HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil),
      "Couldn't create a response"
    )

    let mockedData = Data()
    mockedSessionManager?.mockAnswer = (data: Data(), response:  response)
    
    let request = MockRequest(queryParameters: ["address" : "Dallas, TX"])
    let publisher = try XCTUnwrap(
      networkService?.request(endpoint: request),
      "The network service reference is not valid"
    )
    do {
      _ = try awaitPublisher(publisher)
    }
    catch {
      XCTAssertEqual(error as? NetworkError, NetworkError.error(statusCode: 404, data: mockedData))
      return
    }
    XCTFail("The test should caught the error")
  }

  func testNetworkService_notConnectedToInternet() throws {
    let mockError = URLError(.notConnectedToInternet)
    try handleFailureCase(with: mockError, and: NetworkError.notConnected)
  }
  
  func testNetworkService_networkConnectionLost() throws {
    let mockError = URLError(.networkConnectionLost)
    try handleFailureCase(with: mockError, and: NetworkError.notConnected)
  }

  func testNetworkService_cancel() throws {
    let mockError = URLError(.cancelled)
    try handleFailureCase(with: mockError, and: NetworkError.cancelled)
  }

  func testNetworkService_badURL() throws {
    let mockError = URLError(.badURL)
    try handleFailureCase(with: mockError, and: NetworkError.urlGeneration)
  }

  func testNetworkService_unsupportedURL() throws {
    let mockError = URLError(.unsupportedURL)
    try handleFailureCase(with: mockError, and: NetworkError.urlGeneration)
  }
  
  func testNetworkService_generalError() throws {
    let mockError = URLError(.unknown)
    try handleFailureCase(with: mockError, and: NetworkError.generic(mockError))
  }

  func testNetworkService_success() throws {
    let url = try XCTUnwrap(
      URL(string: "http://some.host.com/endpoint/path/dataSourceFileName"),
      "Couldn't create URL"
    )
    let request = MockRequest(queryParameters: ["address" : "Dallas, TX"])
    let response = try XCTUnwrap(
      HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
      "Couldn't create a response"
    )
    let data = Data(repeating: 0, count: 200)
    
    mockedSessionManager?.mockAnswer = (data: data, response: response)
    let publisher = try XCTUnwrap(
      networkService?.request(endpoint:request),
      "The network reference is not valid"
    )
    let result = try awaitPublisher(publisher)
    let resultData = try XCTUnwrap(result, "Expected the data")

    XCTAssertEqual(resultData, data)
  }
 
  // MARK: private API helper
  private func handleFailureCase( with error: URLError, and expected: NetworkError,
                                  file: StaticString = #file, line: UInt = #line) throws {
    mockedSessionManager?.mockError = error

    let request = MockRequest(queryParameters: ["address" : "Dallas, TX"])
    let publisher = try XCTUnwrap(
      networkService?.request(endpoint: request),
      "The network service reference is not valid" ,
      file: file,
      line: line
    )
    do {
      _ = try awaitPublisher(publisher)
    }
    catch {
      XCTAssertEqual((error as? NetworkError), expected, file: file, line: line)
      return
    }
    XCTFail("The test should caught the error", file: file, line: line)
  }
}

struct MockRequest: Requestable {
  var path: String = ""
  var isFullPath: Bool = true
  var method: HTTPMethodType = .get
  var headers: [String : String] = ["Content": "application/json", "Content-Type": "application/json"]
  var queryParametersEncodable: Encodable?
  var bodyParametersEncodable: Encodable?
  var queryParameters: [String : Any]
  var bodyParameters: [String : Any] = [:]
  var bodyEncoding: Encoding = .jsonSerializationData
}

struct MockAPIConfig: NetworkConfigurable {
  var baseURL: URL
  var headers: [String : String]
  var queryParameters: [String : String]
}


class MockNetworkSessionManager: NetworkSessionManagerProtocol {
  var mockAnswer: (data: Data, response: URLResponse)?
  var mockError: URLError?
  
  var testDownloadTaskCalled = false

  func dataTask(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    if let error = mockError {
      return Fail(error: error).eraseToAnyPublisher()
    }
    
    guard let answer = mockAnswer else {
      return Fail(error: URLError( .failedTest_theAnswerWasNotProvided )).eraseToAnyPublisher()
    }

    return Just(answer).setFailureType(to: URLError.self ).eraseToAnyPublisher()
  }
}

extension URLError.Code {
  public static var failedTest_theAnswerWasNotProvided = URLError.Code( rawValue: -10000 )
}
