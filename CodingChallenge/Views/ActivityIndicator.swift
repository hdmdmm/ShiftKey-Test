//
//  ActivityIndicator.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 27.11.22.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  typealias UIViewType = UIActivityIndicatorView
  @Binding var isAnimating: Bool
  let style: UIActivityIndicatorView.Style
  
  func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
    return UIViewType(style: style)
  }
  
  func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}
