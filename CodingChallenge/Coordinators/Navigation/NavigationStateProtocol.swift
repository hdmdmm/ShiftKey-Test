//
//  NavigationStateProtocol.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 30.11.22.
//

import Foundation
import SwiftUI

public enum NavigationType {
  case push, present, presentFullScreen
}

public protocol RouterProtocol {
  associatedtype V: View
  
  var navigationType: NavigationType { get }

  @ViewBuilder
  func view() -> V
}



protocol AnyContentLink {}
protocol ContentLink: Hashable, Identifiable, AnyContentLink {}


protocol NavigationStateProtocol: ObservableObject {
  var activatedLink: AnyContentLink? { get set }
}

protocol FlowCoordinatorProtocol {
  func next(to link: AnyContentLink?) -> AnyView
}
