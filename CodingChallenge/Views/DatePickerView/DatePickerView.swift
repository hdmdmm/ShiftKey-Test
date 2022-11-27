//
//  DatePickerView.swift
//  CodingChallenge
//
//  Created by Dmitry Kh on 25.11.22.
//

import SwiftUI

struct DatePickerView: View {
  @Binding var selectedIndex: Int
  @Binding var list: [String]
  
  var gradient: LinearGradient {
    LinearGradient(
      colors: [
        Color.white,
        Color.white.opacity(0.6),
        Color.white.opacity(0),
        Color.white.opacity(0.6),
        Color.white
      ],
      startPoint: .leading,
      endPoint: .trailing
    )
  }
  
  var body: some View {
    GeometryReader { geometry in
      HStack {
        Spacer()
        PagingView(
          index: $selectedIndex,
          pages: (0..<list.count)
            .map { index in
              ElementView(selectedIndex: $selectedIndex, id: index, title: list[index])
            }
        )
        .frame(width: geometry.size.width/2, height: 32.0)
        Spacer()
      }
      .overlay(gradient.allowsHitTesting(false))
    }
  }
}

struct DatePickerView_Previews: PreviewProvider {
  @State var selectedIndex: Int = 0
  @State var list = ["2022-11-24",
                     "2022-11-25",
                     "2022-11-26",
                     "2022-11-27",
                     "2022-11-28",
                     "2022-11-29"]
  
  static var shared = DatePickerView_Previews()
  static var previews: some View {
    DatePickerView(selectedIndex: shared.$selectedIndex, list: shared.$list)
  }
}
