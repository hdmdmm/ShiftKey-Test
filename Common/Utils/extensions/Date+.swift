//
//  Date+.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import Foundation

extension Date {
  
  func transform(formatOut: String = "MM-dd-yyyy") -> String {
    let dateFormatterOut = DateFormatter()
    dateFormatterOut.dateFormat = formatOut
    return dateFormatterOut.string(from: self)
  }
  
  static func transform(
    date: String,
    formatIn: String = "yyyy-MM-dd HH:mm:ss",
    formatOut: String = "MM-dd-yyyy"
  ) -> String {
    let dateFormatterIn = DateFormatter()
    dateFormatterIn.dateFormat = formatIn
    let dateFormatterOut = DateFormatter()
    dateFormatterOut.dateFormat = formatOut
    guard let date = dateFormatterIn.date(from: date)
    else {
      return ""
    }
    
    return dateFormatterOut.string(from: date)
  }
  
  static func transformToHour(
    date: String,
    formatIn: String = "yyyy-MM-dd HH:mm:ss"
  ) -> Int {
    let dateFormatterIn = DateFormatter()
    dateFormatterIn.dateFormat = formatIn
    guard let date = dateFormatterIn.date(from: date)
    else {
      return 0
    }
    let hour = Calendar.current.component(.hour, from: date)
    return hour
  }
}
