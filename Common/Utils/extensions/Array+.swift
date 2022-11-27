//
//  Array+.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import Foundation

extension Array {
  public subscript(saveIndex index: Int) -> Element? {
    guard index >= 0, index < endIndex else {
      return nil
    }
    return self[index]
  }
}
