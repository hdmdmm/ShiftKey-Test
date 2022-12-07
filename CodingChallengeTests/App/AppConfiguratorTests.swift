//
//  AppConfiguratorTest.swift
//  CodingChallengeTests
//
//  Created by Dmitry Kh on 7.12.22.
//

import XCTest
@testable import CodingChallenge

class AppConfiguratorTest: XCTestCase {
  func testConfigurator_Failed_FileNotFound() throws {
    do {
      _ = try AppConfigurator(fileName: "some.none.exist.filename")
    }
    catch {
      XCTAssertEqual(error as? ConfiguratorErrors, .configFileNotFound)
      return
    }
    XCTFail("Expected error: Config file was not found ")
  }

  func testConfigurator_Failed_DataMismatch() throws {
    do {
      _ = try MockConfigurator(fileName: "AppConfig")
    }
    catch {
      XCTAssertEqual(error as? ConfiguratorErrors, .configDataMismatch)
      return
    }
  }

  // The host value: https://staging-app.shiftkey.com
  // can be configured in the target config or we don't need that test.
  //
  func testConfigurator_Success() throws {
    let config = try AppConfigurator(fileName: "AppConfig")
    XCTAssertEqual(config.model.host, "https://staging-app.shiftkey.com")
  }
}

struct TestModel: Decodable {
  let nonDecodeableMember: String
}

struct MockConfigurator: ConfiguratorProtocol {
  let model: TestModel
  init(fileName: String) throws {
    model = try Self.load(fileName)
  }
}
