//
//  NavigationStateProtocol.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 30.11.22.
//

import Foundation



protocol AnyContentLink {}
protocol ContentLink: Hashable, Identifiable, AnyContentLink {}


protocol NavigationStateProtocol: ObservableObject {
  var activateLink: AnyContentLink? { get set }
}
