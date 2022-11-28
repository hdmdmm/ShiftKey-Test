//
//  PagingView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 25.11.22.
//

import SwiftUI

struct PagingView<Content: View & Identifiable>: View {

  @Binding var index: Int
  @State private var offset: CGFloat = 0
  @State private var isScrolling: Bool = false

  var pages: [Content]

  var body: some View {
    GeometryReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .center, spacing: 0) {
          ForEach(pages) {
            $0.frame(width: proxy.size.width)
          }
        }
      }
      .content.offset(x: isScrolling ? offset : -proxy.size.width * CGFloat(index))
      .frame(width: proxy.size.width, alignment: .leading)
      .gesture(
        DragGesture()
          .onChanged({ value in
            isScrolling = true
            offset = value.translation.width + -proxy.size.width * CGFloat(index)
          })
          .onEnded({ value in
            if -value.predictedEndTranslation.width > proxy.size.width / 2, index < pages.endIndex - 1 {
              index += 1
            }
            if value.predictedEndTranslation.width > proxy.size.width / 2, index > 0 {
              index -= 1
            }
            withAnimation { offset = -proxy.size.width * CGFloat(index) }
            DispatchQueue.main.async { isScrolling = false }
          }))
    }
  }
}
